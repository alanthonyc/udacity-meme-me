//
//  MemeEditor.swift
//  MemeMe
//
//  Created by A. Anthony Castillo on 7/12/15.
//  Copyright (c) 2015 Alon Consulting, Inc. All rights reserved.
//

import UIKit

class MemeEditor: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var textLineTop: UITextField!
    @IBOutlet weak var textLineBottom: UITextField!
    var keyboardIsHidden = true
    var keyboardHeight: CGFloat = 0
    var editingTopLine = false
    var editingBottomLine = false
    var viewIsAdjustedUp = false
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        let memeTextAttributes = [
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 56)!,
            NSStrokeWidthAttributeName: -3.0
        ]
        textLineTop.defaultTextAttributes = memeTextAttributes
        textLineBottom.defaultTextAttributes = memeTextAttributes
        textLineTop.hidden = true
        textLineBottom.hidden = true
        textLineTop.delegate = self
        textLineBottom.delegate = self
        textLineTop.textAlignment = NSTextAlignment.Center
        textLineBottom.textAlignment = NSTextAlignment.Center
        textLineTop.adjustsFontSizeToFitWidth = true
        textLineBottom.adjustsFontSizeToFitWidth = true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.subscribeToKeyboardNotifications()
        editingTopLine = false
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Picker View
    @IBAction func dismissEditor(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func displayImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .PhotoLibrary
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func displayCameraImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .Camera
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.imagePickerView.image = image
            self.imagePickerView.contentMode = .ScaleAspectFit
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        textLineTop.hidden = false
        textLineBottom.hidden = false
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Keyboard and View Display Management
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if keyboardIsHidden && textLineBottom.isFirstResponder() {
            if !viewIsAdjustedUp {
                self.view.frame.origin.y -= getKeyboardHeight(notification)
            }
            keyboardIsHidden = false
        }
        keyboardHeight = getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if !keyboardIsHidden && textLineBottom.isFirstResponder() {
            if viewIsAdjustedUp {
                self.view.frame.origin.y += getKeyboardHeight(notification)
            }
            keyboardIsHidden = true
            keyboardHeight = 0
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField === textLineTop {
            if editingBottomLine && viewIsAdjustedUp {
                self.view.frame.origin.y += keyboardHeight
                viewIsAdjustedUp = false
            }
            editingTopLine = true
            editingBottomLine = false
        }
        if textField === textLineBottom {
            if editingTopLine && !viewIsAdjustedUp {
                self.view.frame.origin.y -= keyboardHeight
                viewIsAdjustedUp = true
            }
            editingTopLine = false
            editingBottomLine = true
        }
    }
}





















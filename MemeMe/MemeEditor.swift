//
//  MemeEditor.swift
//  MemeMe
//
//  Created by A. Anthony Castillo on 7/12/15.
//  Copyright (c) 2015 Alon Consulting, Inc. All rights reserved.
//

import UIKit

protocol MemeEditorDelegate {
    func finishEditingMeme(line1: String, line2: String, memeImage: UIImage, editedImage: UIImage)
}

class MemeEditor: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var memeView: UIView!
    @IBOutlet weak var textLineTop: MemeLineLabel!
    @IBOutlet weak var textLineBottom: MemeLineLabel!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var topLineEdited = false
    var bottomLineEdited = false
    var keyboardIsHidden = true

    var editMode = false
    var meme: Meme!
    var delegate: MemeEditorDelegate!
    var memedImage: UIImage!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        textLineTop.setupView(56.0)
        textLineBottom.setupView(56.0)
        textLineTop.delegate = self
        textLineBottom.delegate = self
        textLineTop.hidden = true
        textLineBottom.hidden = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "share")
        self.navigationItem.rightBarButtonItem?.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        if editMode {
            setUpEditMode()
        }
        self.subscribeToKeyboardNotifications()

    }
    
    func setUpEditMode() {
        self.navigationItem.rightBarButtonItem?.enabled = true
        imagePickerView?.image = meme.image
        imagePickerView?.contentMode = .ScaleAspectFit
        textLineTop?.text = meme.textLine1
        textLineBottom?.text = meme.textLine2
        textLineTop.hidden = false
        textLineBottom.hidden = false
        topLineEdited = true
        bottomLineEdited = true
        memedImage = meme.memedImage
        cameraButton.enabled = false
        albumButton.enabled = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParentViewController() {
            if delegate != nil {
                self.delegate.finishEditingMeme(textLineTop.text, line2: textLineBottom.text, memeImage: meme.image, editedImage: memedImage)
            }
        }
        self.unsubscribeFromKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    // MARK: - Meme Management
    func share() {
        memedImage = generateMemedImage()
        let activityView : UIActivityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        self.presentViewController(activityView, animated: true, completion: nil)
        if !editMode {
            meme = Meme(textLine1: textLineTop.text, textLine2: textLineBottom.text, image: imagePickerView.image, memedImage: memedImage)
            let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.append(meme)
        }
    }
    
    func generateMemedImage() -> UIImage {
        toolBar.hidden = true
        if !topLineEdited {
            textLineTop.text = ""
        }
        if !bottomLineEdited {
            textLineBottom.text = ""
        }
        
        UIGraphicsBeginImageContext(self.memeView.frame.size)
        let frame = self.memeView.frame
        let rect = CGRectMake(0, 0, frame.width, frame.height)
        self.view.drawViewHierarchyInRect(rect, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolBar.hidden = false
        return memedImage
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
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
        keyboardIsHidden = false
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if !keyboardIsHidden && textLineBottom.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
        keyboardIsHidden = true
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
        if textField === textLineTop && !topLineEdited {
            textField.text = ""
            topLineEdited = true
        }
        if textField === textLineBottom && !bottomLineEdited {
            textField.text = ""
            bottomLineEdited = true
        }
    }
    
    // MARK: - Picker View
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
        topLineEdited = false
        bottomLineEdited = false
        self.navigationItem.rightBarButtonItem?.enabled = true
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}





















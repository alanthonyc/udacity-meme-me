//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by A. Anthony Castillo on 7/17/15.
//  Copyright (c) 2015 Alon Consulting, Inc. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController, MemeEditorDelegate {
    
    @IBOutlet weak var memeImageView: UIImageView!
    var meme: Meme!
    var memeIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        memeImageView.image = meme.memedImage
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func deleteMeme() {
        let appD = UIApplication.sharedApplication().delegate as! AppDelegate
        appD.memes.removeAtIndex(memeIndex)
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func editMeme() {
        let editMemeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("memeEditorVC") as! MemeEditor
        editMemeViewController.meme = meme
        editMemeViewController.editMode = true
        editMemeViewController.delegate = self
        self.navigationController?.pushViewController(editMemeViewController, animated: true)
    }
    
    func finishEditingMeme(line1: String, line2: String, memeImage: UIImage, editedImage: UIImage) {
        meme.textLine1 = line1
        meme.textLine2 = line2
        let appD = UIApplication.sharedApplication().delegate as! AppDelegate
        appD.memes[memeIndex].textLine1 = line1
        appD.memes[memeIndex].textLine2 = line2
        appD.memes[memeIndex].memedImage = editedImage
        appD.memes[memeIndex].image = memeImage
        memeImageView.image = editedImage
    }
}













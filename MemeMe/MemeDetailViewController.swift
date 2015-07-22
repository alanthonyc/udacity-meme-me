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

    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        memeImageView.image = meme.memedImage
    }
    
    // MARK: - Meme Editing Functions
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
    
    // MARK: - Meme Editor Delegate
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













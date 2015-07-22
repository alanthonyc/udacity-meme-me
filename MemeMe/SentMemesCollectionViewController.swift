//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by A. Anthony Castillo on 7/13/15.
//  Copyright (c) 2015 Alon Consulting, Inc. All rights reserved.
//

import UIKit

let reuseIdentifier = "memeCollectionViewCell"

class SentMemesCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var memes: [Meme]!
    var appDelegate: AppDelegate!

    // MARK: - View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        memes = appDelegate.memes
        self.collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell

        let meme = appDelegate.memes[indexPath.item]
        cell.memeImage?.image = meme.image
        cell.imageTopLine?.text = meme.textLine1
        cell.imageBottomLine?.text = meme.textLine2
        cell.memeImage?.contentMode = .ScaleAspectFit
        return cell
    }

    // MARK: - UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let meme = self.memes[indexPath.row]
        if let memeDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("memeDetailVC") as? MemeDetailViewController {
            memeDetailViewController.meme = meme
            memeDetailViewController.memeIndex = indexPath.row
            self.navigationController?.pushViewController(memeDetailViewController, animated: true)
        }
    }
}

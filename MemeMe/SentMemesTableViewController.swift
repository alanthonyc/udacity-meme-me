//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by A. Anthony Castillo on 7/13/15.
//  Copyright (c) 2015 Alon Consulting, Inc. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memes: [Meme]!
    var appDelegate: AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
        self.tableView.rowHeight = 100

        memes = appDelegate.memes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell", forIndexPath: indexPath) as! MemeTableViewCell

        let meme = self.memes[indexPath.row]
        
        cell.memeTopLineTextLabel?.text = meme.textLine1
        cell.memeBottomLineTextLabel?.text = meme.textLine2
        cell.imageTopLine?.text = meme.textLine1
        cell.imageBottomLine?.text = meme.textLine2
        cell.memeImageView?.image = meme.image
        cell.memeImageView?.contentMode = .ScaleAspectFit
        cell.contentView.sizeToFit()
        return cell
    }

    // MARK: - TableView Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let meme = self.memes[indexPath.row]
        if let memeDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("memeDetailVC") as? MemeDetailViewController {
            memeDetailViewController.meme = meme
            memeDetailViewController.memeIndex = indexPath.row
            self.navigationController?.pushViewController(memeDetailViewController, animated: true)
        }
    }
}













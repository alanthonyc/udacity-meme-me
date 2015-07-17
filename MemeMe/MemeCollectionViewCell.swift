//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by A. Anthony Castillo on 7/16/15.
//  Copyright (c) 2015 Alon Consulting, Inc. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageTopLine: MemeLineLabel!
    @IBOutlet weak var imageBottomLine: MemeLineLabel!
    @IBOutlet weak var memeImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageTopLine.setupView(13)
        imageBottomLine.setupView(13)
    }
}

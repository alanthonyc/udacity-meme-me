//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by A. Anthony Castillo on 7/14/15.
//  Copyright (c) 2015 Alon Consulting, Inc. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeTopLineTextLabel: UILabel!
    @IBOutlet weak var memeBottomLineTextLabel: UILabel!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var imageTopLine: MemeLineLabel!
    @IBOutlet weak var imageBottomLine: MemeLineLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageTopLine.setupView(14)
        imageBottomLine.setupView(14)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

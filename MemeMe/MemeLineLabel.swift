//
//  MemeLineLabel.swift
//  MemeMe
//
//  Created by A. Anthony Castillo on 7/16/15.
//  Copyright (c) 2015 Alon Consulting, Inc. All rights reserved.
//

import UIKit

class MemeLineLabel: UITextField {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func setupView(size:CGFloat) {
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: size)!,
            NSStrokeWidthAttributeName: -3.0
        ]
        self.defaultTextAttributes = memeTextAttributes
        self.textAlignment = .Center
        self.adjustsFontSizeToFitWidth = true
        self.autocapitalizationType = .AllCharacters
    }

}

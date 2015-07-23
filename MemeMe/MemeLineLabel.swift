//
//  MemeLineLabel.swift
//  MemeMe
//
//  Created by A. Anthony Castillo on 7/16/15.
//  Copyright (c) 2015 Alon Consulting, Inc. All rights reserved.
//

import UIKit

class MemeLineLabel: UITextField {
    
    func setupView(size:CGFloat) {
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: size)!,
            NSStrokeWidthAttributeName: -3.0
        ]
        defaultTextAttributes = memeTextAttributes
        textAlignment = .Center
        adjustsFontSizeToFitWidth = true
        autocapitalizationType = .AllCharacters
    }

}

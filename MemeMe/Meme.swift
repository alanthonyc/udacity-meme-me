//
//  Meme.swift
//  MemeMe
//
//  Created by A. Anthony Castillo on 7/13/15.
//  Copyright (c) 2015 Alon Consulting, Inc. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    
    var textLine1: String!
    var textLine2: String!
    var image: UIImage!
    var memedImage: UIImage!

    init(textLine1:String!, textLine2: String!, image: UIImage!, memedImage: UIImage!) {
        self.textLine1 = textLine1
        self.textLine2 = textLine2
        self.image = image
        self.memedImage = memedImage
    }
}
//
//  Meme.swift
//  MemeMe
//
//  Created by A. Anthony Castillo on 7/13/15.
//  Copyright (c) 2015 Alon Consulting, Inc. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    var textLine1: String!
    var textLine2: String!
    var image: UIImage!
    var memedImage: UIImage!

    init(topLine:String!, bottomLine: String!, baseImage: UIImage!, memeImage: UIImage!) {
        textLine1 = topLine
        textLine2 = bottomLine
        image = baseImage
        memedImage = memeImage
    }
}
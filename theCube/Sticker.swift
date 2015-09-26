//
//  Sticker.swift
//  theCube
//
//  Created by Jeremy Schmidt on 4/22/15.
//  Copyright (c) 2015 Jeremy Schmidt. All rights reserved.
//

import Foundation



class Sticker
{
    enum PossibleColors
    {
        case red
        case green
        case orange
        case blue
        
        case white
        case yellow
    }
    
    var color: PossibleColors
    
    init(color: PossibleColors)
    {
        self.color = color
    }
    
    
}




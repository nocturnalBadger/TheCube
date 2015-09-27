//
//  Side.swift
//  theCube
//
//  Created by Jeremy Schmidt on 9/26/15.
//  Copyright © 2015 Jeremy Schmidt. All rights reserved.
//

import Foundation

class Side
{
    //var contents = Array<Sticker>()
    var contents = (Dictionary<Character, Sticker>(), Dictionary<Character, Sticker>())
    
    var opposingSide: Side? = nil
    var sidesAffectedByRotation = (Array<Character>(), Array<Character>())
    
    
}
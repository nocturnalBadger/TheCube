//
//  Piece.swift
//  theCube
//
//  Created by Jeremy Schmidt on 4/22/15.
//  Copyright (c) 2015 Jeremy Schmidt. All rights reserved.
//

import Foundation


class Piece
{
    enum types
    {
        case edge
        case corner
    }
    
    var contents = Array<Sticker>()
    let type: types
    
    init(pieceType: types)
    {
        type = pieceType
        
    }
    
}
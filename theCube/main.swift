//
//  main.swift
//  theCube
//
//  Created by Jeremy Schmidt on 4/22/15.
//  Copyright (c) 2015 Jeremy Schmidt. All rights reserved.
//

import Foundation

let cube = buildCubeFromFile("cube")

if cube.contents.count == 6
{
    var indexOfSide = 0
    for side in cube.contents
    {
        side.opposingSide = cube.determineOpposingSide(cube, indexOfSide: indexOfSide)
        indexOfSide++
    }
    
    
}


cube.printCubeContents()
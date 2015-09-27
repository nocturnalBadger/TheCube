//
//  main.swift
//  theCube
//
//  Created by Jeremy Schmidt on 4/22/15.
//  Copyright (c) 2015 Jeremy Schmidt. All rights reserved.
//

import Foundation

enum Error: ErrorType
{
    case badIndex
    case couldNotFindFile
}

let cube = try buildCubeFromFile("cube")


if cube.contents.count == 6
{
    var indexOfSide = 0
    for side in cube.contents
    {
        do
        {
            try side.sidesAffectedByRotation = cube.determinePiecesAffectedByRotation(indexOfSide)
        }
        catch Error.badIndex
        {
            print("This is not good.")
            exit(4) // I don't know anything about exit codes. This one seems nice.
        }
        indexOfSide++
    }
}

cube.printCubeContents()

do
{
    try cube.rotateSide(0)
}
catch
{
    sleep(1)
}


cube.printCubeContents()
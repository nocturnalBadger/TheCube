//
//  Cube.swift
//  theCube
//
//  Created by Jeremy Schmidt on 9/26/15.
//  Copyright © 2015 Jeremy Schmidt. All rights reserved.
//

import Foundation

class Cube
{
    var contents = Array<Side>()
    
    func printCubeContents()
    {
        var readableSideIndex = 1
        for side in self.contents
        {
            print("Side \(readableSideIndex):")
            print("    Corners:")
            for corner in side.contents.1
            {
                print("        \(corner.0): \(corner.1.color)")
            }
            print("    Edges:")
            for edge in side.contents.0
            {
                print("        \(edge.0): \(edge.1.color)")
                
            }
            readableSideIndex++
        }
    }
    
    /*
    func rotateSide(indexOfSide: Int)
    {
        if indexOfSide < self.contents.count
        {
            let side = self.contents[indexOfSide]
        }
        else { sleep(1) }
        
    }
    */
    
    func determineOpposingSide(theCube: Cube, indexOfSide: Int) -> Side
    {
        let opposingSide: Side
        switch indexOfSide
        {
        case 0:
            opposingSide = theCube.contents[5]
        case 1:
            opposingSide = theCube.contents[3]
        case 2:
            opposingSide = theCube.contents[4]
        case 3:
            opposingSide = theCube.contents[1]
        case 4:
            opposingSide = theCube.contents[2]
        case 5:
            opposingSide = theCube.contents[0]
        default:
            opposingSide = theCube.contents[5] // If this happens, we have bigger problems. Space is probably not working properly. Call Mr. Euclid.
        }
        return opposingSide
    }
    
    

}
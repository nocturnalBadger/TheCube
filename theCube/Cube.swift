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
    
    

}
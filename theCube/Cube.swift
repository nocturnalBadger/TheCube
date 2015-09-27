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
    
    enum Error: ErrorType
    {
        case badIndex
    }
    
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
    
    func determineOpposingSide(theCube: Cube, indexOfSide: Int) throws -> Side
    {
        if indexOfSide >= self.contents.count
        {
            throw Error.badIndex
        }
        
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
        default:
            opposingSide = theCube.contents[0]
        }
        return opposingSide
    }
    
    
    func determinePiecesAffectedByRotation(indexOfSide: Int) throws -> (Array<Character>, Array<Character>)
    {
        if indexOfSide >= self.contents.count
        {
            throw Error.badIndex
        }
        let piecesAffected: (Array<Character>, Array<Character>)
        
        switch indexOfSide
        {
        case 0:
            // These are the spefs codes for the pieces affected. They are in the proper order of progression eg. with a clockwise turn of side 0, e will go to q
            piecesAffected.0 = ["e","q","m","i"]
            // Ok, So that's not exactally true for the corners. They each skip one in the order to find their new place. E to Q, F to R, Q to M, R to N etc.
            piecesAffected.1 = ["E","F","Q","R","M","N","I","J"]
        case 1:
            piecesAffected.0 = ["d","l","x","r"]
            piecesAffected.1 = ["A","D","I","L","U","X","S","R"]
        case 2:
            piecesAffected.0 = ["c","p","u","f"]
            piecesAffected.1 = ["D","C","M","P","V","U","G","F"]
        case 3:
            piecesAffected.0 = ["b","t","v","j"]
            piecesAffected.1 = ["C","B","Q","T","W","V","K","J"]
        case 4:
            piecesAffected.0 = ["a","h","w","n"]
            piecesAffected.1 = ["B","A","E","H","X","W","O","N"]
        default:
            piecesAffected.0 = ["g","k","o","s"]
            piecesAffected.1 = ["H","G","L","K","P","O","T","S"]
            
        }
        
        return piecesAffected
    }
    
    

}
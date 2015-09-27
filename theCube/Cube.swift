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
        var readableSideIndex = 0
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
    
    
    func rotateSide(indexOfSide: Int) throws
    {
        do
        {
            let piecesAffected = try determinePiecesAffectedByRotation(indexOfSide)
            let newOrder = (shiftPieces(piecesAffected.0, isCorners: false), shiftPieces(piecesAffected.1, isCorners: true))
            for edgePiece in piecesAffected.0 // For edges
            {
                let workingIndexOfPiece = piecesAffected.0.indexOf(edgePiece)!
                sendPieceToNewLocation(piecesAffected.0[workingIndexOfPiece], newLocation: newOrder.0[workingIndexOfPiece])
                // Wow that's a doosey. Hope it works and I never have to try to fix it.
            }
            for cornerPiece in piecesAffected.1 // For corners
            {
                let workingIndexOfPiece = piecesAffected.1.indexOf(cornerPiece)!
                sendPieceToNewLocation(piecesAffected.1[workingIndexOfPiece], newLocation: newOrder.1[workingIndexOfPiece])
            }
        }
        catch Error.badIndex
        {
            throw Error.badIndex
        }
        
        
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
    
    func shiftPieces(initialState: Array<Character>, isCorners: Bool) -> Array<Character>
    {
        var newState = initialState
        for item in initialState
        {
            let currentItemIndex = initialState.indexOf(item)
            var newItemIndex: Int
            if isCorners
            {
                newItemIndex = currentItemIndex! + 2
            }
            else
            {
                newItemIndex = currentItemIndex! + 1
            }
            if newItemIndex >= initialState.count
            {
                newItemIndex -= initialState.count // Allows for "wrapping" eg: capacity is 6, value is 8, value becomes 2
            }
            newState[newItemIndex] = item
        }
        return newState
    }
    
    func findPieceOnCube(pieceCode: Character) -> Int?
    {
        var indexOfSideContainingPiece: Int?
        var workingIndex = 0
        for side in self.contents
        {
            if side.contents.0[pieceCode] != nil
            {
                indexOfSideContainingPiece = workingIndex
                break
            }
            if side.contents.1[pieceCode] != nil
            {
                indexOfSideContainingPiece = workingIndex
                break
            }
            workingIndex++
        }
        return indexOfSideContainingPiece
    }
    
    func sendPieceToNewLocation(originalLocation: Character, newLocation: Character)
    {
        if String(originalLocation).capitalizedString == String(originalLocation) // if it is a corner
        {
            self.contents[findPieceOnCube(newLocation)!].contents.1[newLocation] = self.contents[findPieceOnCube(originalLocation)!].contents.1[originalLocation]
        }
        else
        {
            self.contents[findPieceOnCube(newLocation)!].contents.0[newLocation] = self.contents[findPieceOnCube(originalLocation)!].contents.0[originalLocation]
        }
    }
}













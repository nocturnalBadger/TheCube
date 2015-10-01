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
        var sideIndex = 0
        for side in self.contents
        {
            print("Side \(sideIndex):")
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
            sideIndex++
        }
    }
    
    
    func rotateSide(indexOfSide: Int, isInverse: Bool) throws
    {
        let stateOfCubeBeforeRotation = self.contents
        
        do
        {
            let piecesAffected = try determinePiecesAffectedByRotation(indexOfSide)
            let newOrderForOtherFaces = (shiftPieces(piecesAffected.0.0, isCorners: false, isInverseTurn: isInverse), shiftPieces(piecesAffected.0.1, isCorners: true, isInverseTurn: isInverse))
            let newOrderForRotatingFace = (shiftPieces(piecesAffected.1.0, isCorners: false, isInverseTurn: isInverse), shiftPieces(piecesAffected.1.1, isCorners: false, isInverseTurn: isInverse))
            for edgePiece in piecesAffected.0.0 // For edges of other faces
            {
                let workingIndexOfPiece = piecesAffected.0.0.indexOf(edgePiece)!
                sendPieceToNewLocation(piecesAffected.0.0[workingIndexOfPiece], newLocation: newOrderForOtherFaces.0[workingIndexOfPiece], stateOfCubeBeforeMovement: stateOfCubeBeforeRotation)
                // Wow that's a doosey. Hope it works and I never have to try to fix it.
            }
            for cornerPiece in piecesAffected.0.1 // For corners of other faces
            {
                let workingIndexOfPiece = piecesAffected.0.1.indexOf(cornerPiece)!
                sendPieceToNewLocation(piecesAffected.0.1[workingIndexOfPiece], newLocation: newOrderForOtherFaces.1[workingIndexOfPiece], stateOfCubeBeforeMovement: stateOfCubeBeforeRotation)
            }
            for edgePiece in piecesAffected.1.0 // For edges of rotating face
            {
                let workingIndexOfPiece = piecesAffected.1.0.indexOf(edgePiece)!
                sendPieceToNewLocation(piecesAffected.1.0[workingIndexOfPiece], newLocation: newOrderForRotatingFace.0[workingIndexOfPiece], stateOfCubeBeforeMovement: stateOfCubeBeforeRotation)
            }
            for cornerPiece in piecesAffected.1.1 // For corners of rotating face
            {
                let workingIndexOfPiece = piecesAffected.1.1.indexOf(cornerPiece)!
                sendPieceToNewLocation(piecesAffected.1.1[workingIndexOfPiece], newLocation: newOrderForRotatingFace.1[workingIndexOfPiece], stateOfCubeBeforeMovement: stateOfCubeBeforeRotation)
            }
        }
        catch Error.badIndex
        {
            throw Error.badIndex
        }
        
        
    }
    
   
    func determinePiecesAffectedByRotation(indexOfSide: Int) throws -> ((Array<Character>, Array<Character>), (Array<Character>, Array<Character>))
    // It would be nice if in the future we could remove all this hardcoding. Maybe there is some way to figure this out.
    {
        if indexOfSide >= self.contents.count
        {
            throw Error.badIndex
        }
        let piecesAffectedOnOtherSides: (Array<Character>, Array<Character>)
        let piecesAffectedOnRotatingSide: (Array<Character>, Array<Character>)
        
        switch indexOfSide
        {
        case 0:
            // These are the spefs codes for the pieces affected. They are in the proper order of progression eg. with a clockwise turn of side 0, e will go to q
            piecesAffectedOnOtherSides.0 = ["e","q","m","i"]
            // Ok, So that's not exactally true for the corners. They each skip one in the order to find their new place. E to Q, F to R, Q to M, R to N etc.
            piecesAffectedOnOtherSides.1 = ["E","F","Q","R","M","N","I","J"]
            piecesAffectedOnRotatingSide.0 = ["a","b","c","d"]
            piecesAffectedOnRotatingSide.1 = ["A","B","C","D"]
        case 1:
            piecesAffectedOnOtherSides.0 = ["d","l","x","r"]
            piecesAffectedOnOtherSides.1 = ["A","D","I","L","U","X","S","R"]
            piecesAffectedOnRotatingSide.0 = ["e","f","g","h"]
            piecesAffectedOnRotatingSide.1 = ["E","F","G","H"]
        case 2:
            piecesAffectedOnOtherSides.0 = ["c","p","u","f"]
            piecesAffectedOnOtherSides.1 = ["D","C","M","P","V","U","G","F"]
            piecesAffectedOnRotatingSide.0 = ["i","j","k","l"]
            piecesAffectedOnRotatingSide.1 = ["I","J","K","L"]
        case 3:
            piecesAffectedOnOtherSides.0 = ["b","t","v","j"]
            piecesAffectedOnOtherSides.1 = ["C","B","Q","T","W","V","K","J"]
            piecesAffectedOnRotatingSide.0 = ["m","n","o","p"]
            piecesAffectedOnRotatingSide.1 = ["M","N","O","P"]
        case 4:
            piecesAffectedOnOtherSides.0 = ["a","h","w","n"]
            piecesAffectedOnOtherSides.1 = ["B","A","E","H","X","W","O","N"]
            piecesAffectedOnRotatingSide.0 = ["q","r","s","t"]
            piecesAffectedOnRotatingSide.1 = ["Q","R","S","T"]
        default:
            piecesAffectedOnOtherSides.0 = ["g","k","o","s"]
            piecesAffectedOnOtherSides.1 = ["H","G","L","K","P","O","T","S"]
            piecesAffectedOnRotatingSide.0 = ["u","v","w","x"]
            piecesAffectedOnRotatingSide.1 = ["U","V","W","X"]
    
        }
        
        return (piecesAffectedOnOtherSides, piecesAffectedOnRotatingSide)
    }
    
    func shiftPieces(initialState: Array<Character>, isCorners: Bool, isInverseTurn: Bool) -> Array<Character>
    {
        var newState = initialState
        let edgeShiftValue: Int
        let cornerShiftValue: Int
        if isInverseTurn
        {
            edgeShiftValue = -1
            cornerShiftValue = -2
        }
        else
        {
            edgeShiftValue = 1
            cornerShiftValue = 2
        }
        for item in initialState
        {
            let currentItemIndex = initialState.indexOf(item)
            var newItemIndex: Int
            if isCorners
            {
                newItemIndex = currentItemIndex! + cornerShiftValue
            }
            else
            {
                newItemIndex = currentItemIndex! + edgeShiftValue
            }
            if newItemIndex >= initialState.count
            {
                newItemIndex -= initialState.count // Allows for "wrapping" eg: capacity is 6, value is 8, value becomes 2
            }
            else if newItemIndex < 0
            {
                newItemIndex += initialState.count
            }
            newState[newItemIndex] = item
        }
        return newState
    }
    
    func findPieceOnCube(pieceCode: Character) -> Int? // Returns a side index
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
    
    func sendPieceToNewLocation(originalLocation: Character, newLocation: Character, stateOfCubeBeforeMovement: Array<Side>)
    {
        if String(originalLocation).capitalizedString == String(originalLocation) // if it is a corner
        {
            let stickerAtOriginalPosition: Sticker = stateOfCubeBeforeMovement[findPieceOnCube(originalLocation)!].contents.1[originalLocation]!
            self.contents[findPieceOnCube(newLocation)!].contents.1[newLocation] = stickerAtOriginalPosition
        }
        else
        {
            let stickerAtOriginalPosition: Sticker = stateOfCubeBeforeMovement[findPieceOnCube(originalLocation)!].contents.0[originalLocation]!
            self.contents[findPieceOnCube(newLocation)!].contents.0[newLocation] = stickerAtOriginalPosition
        }
    }
}













//
//  BuildCube.swift
//  theCube
//
//  Created by Jeremy Schmidt on 4/22/15.
//  Copyright (c) 2015 Jeremy Schmidt. All rights reserved.
//

import Foundation


func buildCubeFromFile(fileName: String) throws -> Cube
{
    let cube = Cube()
    
    var possibleContent: String?
    
    if let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt")
    {
        possibleContent = try? String(contentsOfFile: String(filePath))
    }
    else
    {
        print("Failed to locate file.")
        throw Error.couldNotFindFile
    }
    
    if let content = possibleContent
    {
        let fileContent = content.componentsSeparatedByString("\n")
        
        var pieceLettersToBeAssigned = "abcdABCDefghEFGHijklIJKLmnopMNOPqrstQRSTuvwxUVWX" //Lower case are edges.
        
        for line in fileContent
        {
            var currentSide = Side()
            
            for letter in line.characters
            {
                var currentPieceColor: Sticker.PossibleColors
                switch letter
                {
                    case "r":
                        currentPieceColor = Sticker.PossibleColors.red
                    case "g":
                        currentPieceColor = Sticker.PossibleColors.green
                    case "o":
                        currentPieceColor = Sticker.PossibleColors.orange
                    case "b":
                        currentPieceColor = Sticker.PossibleColors.blue
                    case "y":
                        currentPieceColor = Sticker.PossibleColors.yellow
                    default:
                        currentPieceColor = Sticker.PossibleColors.white
                    
                }
                let currentPieceLetter: Character = pieceLettersToBeAssigned[pieceLettersToBeAssigned.startIndex]

                if String(currentPieceLetter).capitalizedString == String(currentPieceLetter)
                {
                    currentSide.contents.1[currentPieceLetter] = Sticker(color: currentPieceColor)
                    
                    // If the letter is capitol, put it into the list of corners
                }
                else
                {
                    currentSide.contents.0[currentPieceLetter] = Sticker(color: currentPieceColor)
                    // Otherwise, it's an edge
                }
                pieceLettersToBeAssigned.removeAtIndex(pieceLettersToBeAssigned.startIndex)
            }
            cube.contents.append(currentSide)
        }
    }
    
    return cube
}

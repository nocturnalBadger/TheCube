//
//  BuildCube.swift
//  theCube
//
//  Created by Jeremy Schmidt on 4/22/15.
//  Copyright (c) 2015 Jeremy Schmidt. All rights reserved.
//

import Foundation


func buildCubeFromFile(fileName: String)
{
    var possibleContent: String?
    
    if let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt")
    {
        possibleContent = try? String(contentsOfFile: String(filePath))
    }
    else
    {
        print("Failed to locate file.")
    }
    
    if let content = possibleContent
    {
        let fileContent = content.componentsSeparatedByString("\n")
        for line in fileContent
        {
            var currentPiece: Piece
            
            if (line.characters.count == 2)
            {
                currentPiece = Piece(pieceType: Piece.types.edge)
            }
            else
            {
                currentPiece = Piece(pieceType: Piece.types.corner)
            }
            
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
                currentPiece.contents.append(Sticker(color: currentPieceColor))
            }
        }
    }
}
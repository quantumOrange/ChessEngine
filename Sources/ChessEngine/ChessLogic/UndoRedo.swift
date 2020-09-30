//
//  File.swift
//  
//
//  Created by David Crooks on 30/09/2020.
//

import Foundation


extension Chessboard {
    public mutating func undo() -> Bool {
        if moves.count == 0 { return false }
       // let n = moves.count
        let move = moves.removeLast()
        redoableMoves.append(move)
        //remove the piece that were placed
        self[move.addFirst.square]  = nil

        if let addSecond = move.addSecond {
            self[addSecond.square] = nil
        }

        // replace the pieces that were removed
      
        self[move.removeFirst.square]  = move.removeFirst.piece

        if let removesecond = move.removeSecond {
            if move.addSecond == nil {
                // a piece was taken
                _ = takenPieces.removeLast()
            }
           
            self[removesecond.square] = removesecond.piece
        }

        if let stateChange = move.castleStateChange {
            self.castelState = stateChange.from
        }
        
        whosTurnIsItAnyway = !whosTurnIsItAnyway
        return true
    }
    
    public mutating func redo() -> Bool
    {
        guard let lastUndo = redoableMoves.popLast() else { return false }
        apply(move: lastUndo)
        return true
    }
}

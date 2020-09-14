//
//  ApplyMoves.swift
//  Chess
//
//  Created by David Crooks on 18/03/2020.
//  Copyright © 2020 david crooks. All rights reserved.
//

import Foundation

public func apply(move:Move, to board:Chessboard) -> Chessboard? {
     guard let chessMove = validate(chessboard: board, move: move) else { return nil }
    return  apply(move:chessMove, to:board)
}


public func apply(move:ChessMove, to board:Chessboard) -> Chessboard? {
    var board = board
    board.apply(move: move)
    return board
}

extension Chessboard {
    mutating func apply(move:ChessMove )  {
       
    
       // self.quickValue -=  move.removeFirst.piece.value
        self[move.removeFirst.square]  = nil
        
        
        if let removeSecond = move.removeSecond {
            if move.addSecond == nil {
                // we are removing a piec but not putting it back => taking a peice
                takenPieces.append(removeSecond.piece)
            }
          
            self[removeSecond.square] = nil
        }
        
       // self.quickValue +=  move.addFirst.piece.value
        self[move.addFirst.square]  = move.addFirst.piece
        
        if let addsecond = move.addSecond {
          //  self.quickValue +=  addsecond.piece.value
            self[addsecond.square] = addsecond.piece
        }
        
        moves.append(move)
        
        if let stateChange = move.castleStateChange {
            self.castelState = stateChange.to
        }
        
        whosTurnIsItAnyway = !whosTurnIsItAnyway
        
        return
        
    }
    
    mutating func undo() -> Bool {
        if moves.count == 0 { return false }
       // let n = moves.count
        let move = moves.removeLast()
              
        //remove the piece that were placed
       // self.quickValue -=  move.addFirst.piece.value
        self[move.addFirst.square]  = nil

        if let addSecond = move.addSecond {
        //    self.quickValue -=  addSecond.piece.value
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
}

func apply(move:ChessMove, to board:Chessboard) -> Chessboard{
    var mutableBoard = board
    mutableBoard.apply(move: move)
    return mutableBoard
}

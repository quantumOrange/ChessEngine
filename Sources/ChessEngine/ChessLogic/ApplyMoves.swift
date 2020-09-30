//
//  ApplyMoves.swift
//  Chess
//
//  Created by David Crooks on 18/03/2020.
//  Copyright © 2020 david crooks. All rights reserved.
//

import Foundation

public func applyMoveIfValid(board:inout Chessboard,move:Move)->Bool{
    guard let validatedMove = validate(chessboard:board, move:move) else { return false }
    
    board.apply(move:validatedMove)
    board.gamePlayState = gamePlayState(chessboard: board)
    board.redoableMoves = []
    return true
}

public func applyMoveIfValid(board:inout Chessboard,move:ChessMove)->Bool{
    guard let validatedMove = validate(chessboard:board, move:move) else { return false }
    
    board.apply(move:validatedMove)
    board.gamePlayState = gamePlayState(chessboard: board)
    board.redoableMoves = []
    return true
}

public func apply(move:Move, to board:Chessboard) -> Chessboard? {
     guard let chessMove = validate(chessboard: board, move: move) else { return nil }
     return apply(move:chessMove, to:board)
}


public func apply(move:ChessMove, to board:Chessboard) -> Chessboard {
    var mutableBoard = board
    mutableBoard.apply(move: move)
    mutableBoard.redoableMoves = []
    return mutableBoard
}

extension Chessboard {
    mutating func apply(move:ChessMove )  {

        self[move.removeFirst.square]  = nil
        
        
        if let removeSecond = move.removeSecond {
            if move.addSecond == nil {
                // we are removing a piece but not putting it back => taking a peice
                takenPieces.append(removeSecond.piece)
            }
          
            self[removeSecond.square] = nil
        }

        self[move.addFirst.square]  = move.addFirst.piece
        
        if let addsecond = move.addSecond {
            self[addsecond.square] = addsecond.piece
        }
        
        moves.append(move)
        
        
        if let stateChange = move.castleStateChange {
            self.castelState = stateChange.to
        }
        
        whosTurnIsItAnyway = !whosTurnIsItAnyway
        
        return
        
    }
    
}



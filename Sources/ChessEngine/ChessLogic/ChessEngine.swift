//
//  ChessEngine.swift
//  Chess
//
//  Created by david crooks on 16/09/2019.
//  Copyright © 2019 david crooks. All rights reserved.
//

import Foundation
func evaluateMove(_ board:Chessboard, noise:Float) -> (ChessMove) -> Float {
    return { move in
        var board = board
        board.apply(move: move)
        return board.evaluate(); //+ Float.random(in: -noise...noise)
    }
}

public func pickMove(for board:Chessboard , depth:Int = 3) -> ChessMove? {
    let start = DispatchTime.now() // <<<<<<<<<< Start time
   
    let move = pickMoveMiniMax(for: board, depth:depth)
    let end = DispatchTime.now()
    let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // nano seconds (UInt64)
    let timeInterval = Double(nanoTime) / 1_000_000_000

    print("Time to find best move to depth \(depth): \(timeInterval)")
    return move
}

func pickMoveSimple(for board:Chessboard) -> ChessMove? {
    
    let moves = validMoves(chessboard:board)
    
    let multiplier:Float =  board.whosTurnIsItAnyway == .black ? -1.0 : 1.0
    
    let values =  moves
                    .map(evaluateMove(board,noise:0.5))
                    .map { $0 * multiplier }
    
    let result = zip(moves, values)
                            .max(by:{ $0.1 < $1.1})
                            
    
    if let (bestMove,_) = result {
        return bestMove
    }
    else {
        return nil
    }
}

func randomChessboard(_ n:Int) -> Chessboard {
    (0...n).reduce(Chessboard.start()){ board , i in
        guard let move =  pickMove(for: board) else { return board }
        return apply(move: move, to: board)
    }
}

func randomChessboard(n:Int) ->  [Chessboard] {
    (0...n)
        .map{ _ in Int.random(in: 4...20 )  }
        .map( randomChessboard )
}

func pickMove2(for board:Chessboard) -> ChessMove? {
       
    evaluateMoves(chessboard:board, depth: 3)
        .sorted()
        .first?
        .move
}

struct EvaluatedMove:Comparable {
    static func < (lhs: EvaluatedMove, rhs: EvaluatedMove) -> Bool {
        lhs.value < rhs.value
    }
    
    let move:ChessMove
    let value:Float
}

func evaluateMoves(chessboard:Chessboard, depth:Int) -> [EvaluatedMove] {
    return evaluateMovesByPoints(board: chessboard)
}

func evaluateMovesByPoints(board:Chessboard) -> [EvaluatedMove] {
    let moves = validMoves(chessboard:board)
    
    let values = moves
                .map{ apply( move: $0 ,to: board) }
                .map{ $0.evaluate()                     }
                .map{ $0 + Float.random(in: -0.5...0.5) }
              
    
    return zip(moves, values)
                .map(EvaluatedMove.init)
    
}


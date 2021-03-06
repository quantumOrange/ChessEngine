//
//  ChessMove.swift
//  Chess
//
//  Created by david crooks on 18/08/2019.
//  Copyright © 2019 david crooks. All rights reserved.
//

import Foundation

public struct ChessMove:Equatable,CustomStringConvertible,Codable {
    
    public var description: String {
        "\(from)->\(to)"
    }
    
    public var from:Int8 {
        return removeFirst.square
    }
    
    public var to:Int8 {
        return addFirst.square
    }
        
    let removeFirst:ChessChange
    let addFirst:ChessChange
    let removeSecond:ChessChange?
    let addSecond:ChessChange?
      
    var castleStateChange:CastleStateChange? = nil
    
    static func createMove( from:Int8,to:Int8,  on board:Chessboard, promote:ChessPiece.Kind? = nil)-> ChessMove? {
        guard let movePiece = board[from] else { return nil }
        return ChessMove(from:from, to:to, movePiece:movePiece, takePiece:board[to], promote: promote)
    }
    
    init?( from:Int8,to:Int8, movePiece:ChessPiece, takePiece:ChessPiece?, promote:ChessPiece.Kind? = nil ) {
        //guard let movePiece = board[from] else { return nil }
              
              removeFirst =  ChessChange(square: from, piece: movePiece)
              
              var addPiece = movePiece
              
              if let takePiece = takePiece {
                  removeSecond = ChessChange(square: to, piece: takePiece)
              }
              else {
                  removeSecond = nil
              }
              
        if let kind = promote {
                   addPiece = ChessPiece(player: movePiece.player, kind: kind, id: movePiece.id)
               }
              addSecond = nil // only for castles which has its own init
              
              addFirst = ChessChange(square: to, piece:addPiece)
             
    }
    
    static func createMove( from:Int8,to:Int8, on board:Chessboard, updateCasteleState:Bool  ) -> ChessMove? {
        guard let movePiece = board[from] else { return nil }
        return ChessMove(from:from, to:to, movePiece:movePiece, takePiece:board[to], casteleState:board.castelState)
    }
    
    init?( from:Int8,to:Int8, movePiece:ChessPiece, takePiece:ChessPiece?,  casteleState:Chessboard.CastelState ) {
       
       // guard let movePiece = board[from] else { return nil }
        
        removeFirst =  ChessChange(square: from, piece: movePiece)
        
        //var addPiece = movePiece
        
        if let takePiece = takePiece {
            removeSecond = ChessChange(square: to, piece: takePiece)
        }
        else {
            removeSecond = nil
        }
        
        addSecond = nil // only for castles which has its own init
        //changes.append(ChessChange(type: .add, square: to, piece:addPiece))
        addFirst = ChessChange(square: to, piece:movePiece)
       
       // if let casteleState = casteleState {
            let changes = [removeFirst]
            self.castleStateChange = CastleStateChange(changes:changes , initialState:casteleState)
       // }
         
    }
    
   /*
    var promotion:ChessPiece.Kind? {
        guard case .promote(let piece) = auxillery else { return nil }
        return piece
    }
    */
}

struct ChessChange:Codable,Equatable{
    /*
    enum ChangeType:String,Codable
    {
        case remove
        case add
        
    }
    
    let type:ChangeType
    */
    let square:Int8
    let piece:ChessPiece
}


struct CastleStateChange:Codable,Equatable {
    let from:Chessboard.CastelState
    let to:Chessboard.CastelState
    
    init?(changes:[ChessChange],initialState:Chessboard.CastelState) {
        self.from = initialState
        guard let finalState = initialState.movingPieces(changes: changes) else  { return nil }
        self.to = finalState
    }
}


public struct Move:Equatable,Codable {
    public let from:ChessboardSquare
    public let to:ChessboardSquare
    
    public init(from:ChessboardSquare, to:ChessboardSquare ){
        self.from = from
        self.to = to
    }
}

extension Move {
     init?(code:String) {
        
        guard   let from    = ChessboardSquare(code:String(code.prefix(2))),
                let to      = ChessboardSquare(code:String(code.suffix(2)))
                                                                    else { return nil }
        self.from = from
        self.to = to
    }
}

extension Move {
    public init?(from:Int8 ,to:Int8) {
        self.from = from.chessboardSquare
        self.to = to.chessboardSquare
    }
}

func isYourPiece(chessboard:Chessboard, move:ChessMove) -> Bool {
    return isYourPiece(chessboard: chessboard, square: move.from)
}

func isYourPiece(chessboard:Chessboard, square:Int8) -> Bool {
    guard let thePieceToMove = chessboard[square] else {
        //You can't move nothing
        return false
    }
    
    return chessboard.whosTurnIsItAnyway == thePieceToMove.player
}

public func isYourPiece(chessboard:Chessboard, square:ChessboardSquare) -> Bool {
    return isYourPiece(chessboard: chessboard, square: square.int8Value)
}

//
//  ChessboardSquare.swift
//  Chess
//
//  Created by david crooks on 15/09/2019.
//  Copyright © 2019 david crooks. All rights reserved.
//

import Foundation

extension Int8 {
    var rank:Int8 {
        self % 8
    }
    
    var file:Int8 {
       self / 8
    }
    
    public var chessboardSquare:ChessboardSquare {
        ChessboardSquare(rank: ChessRank.init(rawValue: self.rank)!, file: ChessFile.init(rawValue: self.file)!)
    }
    
    
    func getNeighbour(_ direction:Direction) -> Int8?
    {
           
           var rawRank = rank
           var rawFile = file
           
           switch direction {
           
           case .top:
               rawRank += 1
           case .bottom:
               rawRank -= 1
           case .left:
               rawFile -= 1
           case .right:
               rawFile += 1
           case .topLeft:
               rawFile -= 1
               rawRank += 1
           case .topRight:
               rawFile += 1
               rawRank += 1
           case .bottomLeft:
               rawFile -= 1
               rawRank -= 1
           case .bottomRight:
               rawFile += 1
               rawRank -= 1
           }
        
        if rawRank >= 0 && rawRank <= 7 &&  rawFile >= 0 && rawFile <= 7 {
             // sq = 8 * file + rank
            return 8 * rawFile + rawRank
        }
        
        return nil
    }
}

public enum ChessboardSquare:Int8,Equatable,Hashable,Codable {
    case a1
    case a2
    case a3
    case a4
    case a5
    case a6
    case a7
    case a8
    case b1
    case b2
    case b3
    case b4
    case b5
    case b6
    case b7
    case b8
    case c1
    case c2
    case c3
    case c4
    case c5
    case c6
    case c7
    case c8
    case d1
    case d2
    case d3
    case d4
    case d5
    case d6
    case d7
    case d8
    case e1
    case e2
    case e3
    case e4
    case e5
    case e6
    case e7
    case e8
    case f1
    case f2
    case f3
    case f4
    case f5
    case f6
    case f7
    case f8
    case g1
    case g2
    case g3
    case g4
    case g5
    case g6
    case g7
    case g8
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6
    case h7
    case h8
}

extension ChessboardSquare {
    public init(rank:ChessRank, file: ChessFile)
    {
        let raw = Int8(file.rawValue*8 + rank.rawValue)
        self = ChessboardSquare(rawValue: raw)! // cannot fail because rank and file raw values are in 0..<8, so raw is in 0..<64
    }
    
    public var rank:ChessRank {
        ChessRank(rawValue:self.rawValue.rank)! // cannot fail because the rank raw vaule is in 0..<8
    }
    
    public var file:ChessFile {
         ChessFile(rawValue:self.rawValue.file)! // cannot fail because the file raw vaule is in 0..<8
    }

    public init?(code:String)
    {
        guard   let rank = ChessRank(code:String(code.suffix(1))),
                       let file = ChessFile(code:String(code.prefix(1)))     else { return nil }
        
        self = ChessboardSquare(rank: rank, file: file)
    }
    
    // TODO: remove this
    var int8Value:Int8 {
        rawValue
    }
}

enum Direction:CaseIterable {
    case top,bottom,left,right
    case bottomLeft,bottomRight,topLeft,topRight
}

extension ChessboardSquare {
    
    // Directions viewed from whites perspective
    
    
    func getNeighbour(_ direction:Direction) -> ChessboardSquare? {
        
        var rawRank = rank.rawValue
        var rawFile = file.rawValue
        
        switch direction {
        
        case .top:
            rawRank += 1
        case .bottom:
            rawRank -= 1
        case .left:
            rawFile -= 1
        case .right:
            rawFile += 1
        case .topLeft:
            rawFile -= 1
            rawRank += 1
        case .topRight:
            rawFile += 1
            rawRank += 1
        case .bottomLeft:
            rawFile -= 1
            rawRank -= 1
        case .bottomRight:
            rawFile += 1
            rawRank -= 1
        }
        
        if let newRank = ChessRank(rawValue: rawRank),
            let newFile = ChessFile(rawValue: rawFile) {
             return ChessboardSquare(rank: newRank, file: newFile)
        }
        
        return nil
    }
}

extension Chessboard {
   
    func squares(with piece:ChessPiece) -> [ChessboardSquare] {
        squares.filter{
            guard let otherPiece = self[$0]  else { return false }
            return ( otherPiece.kind == piece.kind && otherPiece.player == piece.player )
        }
    }
    
    public var positionPieces: [(ChessboardSquare,ChessPiece)] {
        return squares.compactMap {
            guard let piece = self[$0] else { return nil }
            return ($0,piece)
        }
    }
    
    
}


extension ChessboardSquare:CustomStringConvertible {
    public var description: String {
        "\(file)\(rank)"
    }
}

extension ChessboardSquare:Identifiable {
    public var id: Int {
        (self.file.id * 8 + self.rank.id)
    }
}


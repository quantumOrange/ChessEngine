//
//  ValidMoves.swift
//  ChessTests
//
//  Created by david crooks on 15/09/2019.
//  Copyright © 2019 david crooks. All rights reserved.
//

import XCTest
@testable import ChessEngine

class ValidMoves: XCTestCase {
    let simpleMoves = [
        Move(code:"e2->e4")!,
        Move(code:"e7->e6")!,
        Move(code:"f1->c4")!,
        Move(code:"h7->h6")!,
        Move(code:"d1->f3")!,
        Move(code:"f8->a3")!,
        Move(code:"b2->b3")!,
        Move(code:"a3->c1")!,
        Move(code:"b1->c3")!,
        Move(code:"c1->d2")!,
        Move(code:"e1->d2")!,
        Move(code:"h8->h7")!,
        Move(code:"a1->d1")!,
        Move(code:"h7->h8")!,
        Move(code:"g1->h3")!,
        Move(code:"e6->e5")!,
        Move(code:"h1->e1")!,
        Move(code:"g7->g6")!
    ]
    
    var developedBoard:Chessboard!
    
    override func setUp() {
        
        developedBoard = Chessboard.start()
        
        for move in simpleMoves {
            developedBoard  = apply(move: move, to: developedBoard )
        }
 
    }

    override func tearDown() {
        developedBoard = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testNumberOfValidOpeningMovesForWhite() {
        let board = Chessboard.start()
        
        let moves = validMoves(chessboard: board)
        
        XCTAssert(moves.count == 20, "There should be 20 (16 pawns, 4 knights) valid first moves, found \(moves.count)")
        
        let pawnMoves = moves.filter{board[$0.from]?.kind == .pawn}
        
        XCTAssert(pawnMoves.count == 16, "There should be 16  valid first pawn moves, found \(pawnMoves.count)")
        
        let knightMoves = moves.filter{board[$0.from]?.kind == .knight}
        
        XCTAssert(knightMoves.count == 4, "There should be 4 valid first knight moves, found \(knightMoves.count)")
        
        XCTAssert(moves.allSatisfy{ board[$0.from]?.player == .white}, "All opening moves should be white pieces")
            
    }
    
    func testNumberOfValidOpeningMovesForBlack() {
        //white moves a pawn
        let board = apply( move: Move(from: ChessboardSquare(rank: ._2, file: .e), to: ChessboardSquare(rank: ._3, file: .e)), to: Chessboard.start())!
        
        let moves = validMoves(chessboard: board)
        
        XCTAssert(moves.count == 20, "There should be 20 (16 pawns, 4 knights) valid first moves, found \(moves.count)")
        
        let pawnMoves = moves.filter{board[$0.from]?.kind == .pawn}
        
        XCTAssert(pawnMoves.count == 16, "There should be 16  valid first pawn moves, found \(pawnMoves.count)")
        
        let knightMoves = moves.filter{board[$0.from]?.kind == .knight}
        
        XCTAssert(knightMoves.count == 4, "There should be 4 valid first knight moves, found \(knightMoves.count)")
        
        XCTAssert(moves.allSatisfy{ board[$0.from]?.player == .black}, "All moves after white has moved should be black pieces")
            
    }
    
    func testValidateSimpleMoves() {
        
        //A valid sequence of simple moves for a game
        let moves:[Move] = [
                                    Move(code:"e2->e4")!,
                                    Move(code:"e7->e6")!,
                                    Move(code:"f1->c4")!,
                                    Move(code:"h7->h6")!,
                                    Move(code:"d1->f3")!,
                                    Move(code:"f8->a3")!,
                                    Move(code:"b2->b3")!,
                                    Move(code:"a3->c1")!,
                                    Move(code:"b1->c3")!,
                                    Move(code:"c1->d2")!,
                                    Move(code:"e1->d2")!,
                                    Move(code:"h8->h7")!,
                                    Move(code:"a1->d1")!,
                                    Move(code:"h7->h8")!,
                                    Move(code:"g1->h3")!,
                                    Move(code:"e6->e5")!,
                                    Move(code:"h1->e1")!,
                                    Move(code:"g7->g6")!
                                ]
        
        var  board = Chessboard.start()
        
        for move in moves {
           // print("Move : \(move)")
            XCTAssert(isValid(move:move, on:board ), "move \(move) should be valid")
            board = apply(move: move, to: board)!
        }
        
        
        XCTAssertFalse( isValid(move:Move(code:"c4->c5")!, on:board ), "bishop cannot move up the file")
        XCTAssertFalse( isValid(move:Move(code:"c3->d3")!, on:board ), "knight cannot move one sideways")
        XCTAssertFalse( isValid(move:Move(code:"b3->b2")!, on:board ), "pawn cannot move backwards")
        
    }
    
    func testValidBishopMoves() {
        let square = ChessboardSquare(code: "d4")!.int8Value
                  let emptyboardStr =      """

                                             8   .  .  .  .  .  .  .  .
                                             7   .  .  .  .  .  .  .  .
                                             6   .  .  .  .  .  .  .  .
                                             5   .  .  .  .  .  .  .  .
                                             4   .  .  .  ♗  .  .  .  .
                                             3   .  .  .  .  .  .  .  .
                                             2   .  .  .  .  .  .  .  .
                                             1   .  .  .  .  .  .  .  .
                                                 
                                                 a  b  c  d  e  f  g  h

                                             """
        /*
         8   .  .  .  .  .  .  .  .
         7   .  .  .  .  .  .  v  .
         6   .  .  .  .  .  ♙  .  .
         5   .  .  v  .  .  .  .  .
         4   .  .  .  ♗  .  i  .  .
         3   .  .  ♟  .  .  .  .  .
         2   .  v  .  .  .  .  .  .
         1   .  .  .  .  .  .  v  .
             
             a  b  c  d  e  f  g  h
          */
                   var board = Chessboard(string: emptyboardStr)!
                  
             let valid1 = ChessMove.createMove(from: square, to: ChessboardSquare(code: "b2")!.int8Value, on: board)!
             let valid2 = ChessMove.createMove(from: square, to: ChessboardSquare(code: "c5")!.int8Value, on: board)!
             let valid3 = ChessMove.createMove(from: square, to: ChessboardSquare(code: "g1")!.int8Value, on: board)!
             let valid4 = ChessMove.createMove(from: square, to: ChessboardSquare(code: "g7")!.int8Value, on: board)!


             let invalid = ChessMove.createMove(from: square, to: ChessboardSquare(code: "f1")!.int8Value,on: board)!
                  
            assert(board[square]!.kind == .bishop)
        
            
        //   print(square.int8Value)
         let moves =  validBishopMoves(board:board, square: square)
        //   let moves:[ChessMove] = []
           XCTAssert(moves.count == 13, "Expected 13 moves, found  \(moves.count)")
           XCTAssert(moves.contains(valid1))
           XCTAssert(moves.contains(valid2))
           XCTAssert(moves.contains(valid3))
           XCTAssert(moves.contains(valid4))
           XCTAssertFalse(moves.contains(invalid))
        
        
       //add a couple of obstaclles
            board[ChessboardSquare(code: "c3")!.int8Value]  =  ChessPiece(player: .black, kind: .pawn, id: 1)
            board[ChessboardSquare(code: "f6")!.int8Value]  =  ChessPiece(player: .white, kind: .pawn, id: 2)
        let moves2 =  validBishopMoves(board:board, square: square)
          
        
           let valid5 = ChessMove.createMove(from: square, to: ChessboardSquare(code: "c3")!.int8Value, on: board)! // we can take the black pawn
        
           let invalid1 = ChessMove.createMove(from: square, to: ChessboardSquare(code: "b2")!.int8Value, on: board)! // but we  can gono further in that direction
        
           let invalid2 = ChessMove.createMove(from: square, to: ChessboardSquare(code: "f6")!.int8Value, on: board)! // and we cannot pass our own pawn
           let invalid3 = ChessMove.createMove(from: square, to: ChessboardSquare(code: "g7")!.int8Value, on: board)! // and we cannot pass our own pawn
        
        
        XCTAssert(moves2.count == 8, "Expected 8 moves, found  \(moves.count)")
        XCTAssert(moves2.contains(valid5))
        XCTAssertFalse(moves2.contains(invalid1))
        XCTAssertFalse(moves2.contains(invalid2))
        XCTAssertFalse(moves2.contains(invalid3))
        
        
        //these are on the other diagonal and  should be unchanged
        XCTAssert(moves2.contains(valid2))
        XCTAssert(moves2.contains(valid3))
         //still can't go in this direction
        XCTAssertFalse(moves2.contains(invalid))
    }
    
    func testValidRookMoveOnEmptyBoard() {
        let square = ChessboardSquare(code: "d4")!.int8Value
               let emptyboardStr =      """

                                          8   .  .  .  .  .  .  .  .
                                          7   .  .  .  .  .  .  .  .
                                          6   .  .  .  .  .  .  .  .
                                          5   .  .  .  .  .  .  .  .
                                          4   .  .  .  ♖  .  .  .  .
                                          3   .  .  .  .  .  .  .  .
                                          2   .  .  .  .  .  .  .  .
                                          1   .  .  .  .  .  .  .  .
                                              
                                              a  b  c  d  e  f  g  h

                                          """
                           
              
                let board = Chessboard(string: emptyboardStr)!
               
          let valid1 = ChessMove.createMove(from: square, to: ChessboardSquare(code: "f4")!.int8Value, on: board,updateCasteleState: true)!
          let valid2 = ChessMove.createMove(from: square, to: ChessboardSquare(code: "d7")!.int8Value, on: board,updateCasteleState: true)!
          let valid3 = ChessMove.createMove(from: square, to: ChessboardSquare(code: "c4")!.int8Value, on: board,updateCasteleState: true)!
          let valid4 = ChessMove.createMove(from: square, to: ChessboardSquare(code: "d1")!.int8Value, on: board,updateCasteleState: true)!

          let valid5 = ChessMove.createMove(from: square, to: ChessboardSquare(code: "a4")!.int8Value, on: board,updateCasteleState: true)!
          let valid6 = ChessMove.createMove(from: square, to: ChessboardSquare(code: "d8")!.int8Value, on: board,updateCasteleState: true)!
          let invalid = ChessMove.createMove(from: square, to: ChessboardSquare(code: "b2")!.int8Value,on: board,updateCasteleState: true)!
               
               assert(board[square]!.kind == .rook)
         print("------hello-----")
       // print(square.int8Value)
      let moves =  validRookMoves(board:board, square: square)
     //   let moves:[ChessMove] = []
        XCTAssert(moves.count == 14, "Expected 14 moves, found  \(moves.count)")
        XCTAssert(moves.contains(valid1))
        XCTAssert(moves.contains(valid2))
        XCTAssert(moves.contains(valid3))
        XCTAssert(moves.contains(valid4))
        XCTAssert(moves.contains(valid5))
        XCTAssert(moves.contains(valid6))

        XCTAssertFalse(moves.contains(invalid))
               
    }
    
    func testValidRookMoves() {
        /*
        ♔
        ♖  ♘  ♗  ♕
        ♙
        */
       
        let whiteRookSquare = ChessboardSquare(code: "d4")!.int8Value
        let blackRookSquare = ChessboardSquare(code: "h1")!.int8Value
          let boardStr =      """

                                  8   .  .  .  .  .  .  .  .
                                  7   .  .  .  ♟  .  .  .  .
                                  6   .  .  .  .  .  .  .  .
                                  5   .  .  .  .  .  .  .  .
                                  4   .  ♙  .  ♖  .  .  .  .
                                  3   .  .  .  .  .  .  .  .
                                  2   .  .  .  .  .  .  .  .
                                  1   .  .  .  .  .  .  .  ♜
                                      
                                      a  b  c  d  e  f  g  h

                                  """
                   
       let board = Chessboard(string: boardStr)!
       
       
       
        assert(board[whiteRookSquare]!.kind == .rook)
        assert(board[blackRookSquare]!.kind == .rook)
        
        let moves =  validRookMoves(board:board, square: whiteRookSquare)
        
        let valid1 = ChessMove.createMove(from: whiteRookSquare, to: ChessboardSquare(code: "f4")!.int8Value, on: board, updateCasteleState: true )!
        let valid2 = ChessMove.createMove(from: whiteRookSquare, to: ChessboardSquare(code: "d7")!.int8Value, on: board ,updateCasteleState: true)!
        let valid3 = ChessMove.createMove(from: whiteRookSquare, to: ChessboardSquare(code: "c4")!.int8Value, on: board ,updateCasteleState: true)!
        let valid4 = ChessMove.createMove(from: whiteRookSquare, to: ChessboardSquare(code: "d1")!.int8Value, on: board, updateCasteleState: true)!

        let invalid1 = ChessMove.createMove(from: whiteRookSquare, to: ChessboardSquare(code: "a4")!.int8Value, on: board,updateCasteleState: true)!
        let invalid2 = ChessMove.createMove(from: whiteRookSquare, to: ChessboardSquare(code: "d8")!.int8Value, on: board,updateCasteleState: true)!
        let invalid3 = ChessMove.createMove(from: whiteRookSquare, to: ChessboardSquare(code: "b2")!.int8Value, on: board,updateCasteleState: true)!
        
        XCTAssert(moves.contains(valid1))
        XCTAssert(moves.contains(valid2))
        XCTAssert(moves.contains(valid3))
        XCTAssert(moves.contains(valid4))
        
        XCTAssertFalse(moves.contains(invalid1))
        XCTAssertFalse(moves.contains(invalid2))
        XCTAssertFalse(moves.contains(invalid3))
        
        let blackMoves =  validRookMoves(board:board, square: blackRookSquare)
        
        let valid5 = ChessMove.createMove(from: blackRookSquare, to: ChessboardSquare(code: "e1")!.int8Value, on: board, updateCasteleState: true)!
        let invalid4 = ChessMove.createMove(from: blackRookSquare, to: ChessboardSquare(code: "g3")!.int8Value, on: board, updateCasteleState: true)!
        XCTAssert(blackMoves.count == 14, "expected 14 moves, found \(moves.count)")
        XCTAssert(blackMoves.contains(valid5))
        XCTAssertFalse(blackMoves.contains(invalid4))
    }
    
    
    func testValidKnightMoves() {
        
        /*
                   ♔
                   ♖  ♘  ♗  ♕
                   ♙
                   */
        
        let boardStr =      """

                                   8   .  *  .  *  .  .  .  .
                                   7   *  .  .  .  *  .  .  .
                                   6   .  .  ♘  .  .  .  .  .
                                   5   *  .  .  .  *  .  .  .
                                   4   .  *  .  *  *  .  *  .
                                   3   .  .  .  *  .  .  .  *
                                   2   .  .  .  .  .  ♞  .  .
                                   1   .  .  .  *  .  .  .  ♜
                                       
                                       a  b  c  d  e  f  g  h

                                   """
                    //"b4" , "a5","d4","e5", "a7","b8","d8", "e7"
        var board = Chessboard(string: boardStr)!
        
        let whiteKnightSq = ChessboardSquare(code: "c6")!.int8Value
        let blackKnightSq = ChessboardSquare(code: "f2")!.int8Value
        
        
        assert(board[whiteKnightSq]!.kind == .knight)
        assert(board[blackKnightSq]!.kind == .knight)
        
        let validWhiteKnightMoves = ["b4" , "a5","d4","e5", "a7","b8","d8", "e7"]
                                    .map{ ChessMove.createMove(from: whiteKnightSq, to: ChessboardSquare(code: $0)!.int8Value, on: board)!}
        
        let validBlackKnightMoves = ["d1" , "d3","e4","g4", "h3"]
                                        .map{ ChessMove.createMove(from: blackKnightSq, to: ChessboardSquare(code: $0)!.int8Value, on: board)!}
        
        let whiteresults = validKnightMoves(board: board, square: whiteKnightSq)
        
        
        for move in validWhiteKnightMoves {
            XCTAssert(whiteresults.contains(move) , "\(move) should be valid")
        }
        XCTAssert(whiteresults.count == 8)
        
        board.toggleTurn()
        
        let blackresults = validKnightMoves(board: board, square: blackKnightSq)
           
           for move in validBlackKnightMoves {
               XCTAssert(blackresults.contains(move) , "\(move) should be valid")
           }
        
        let invalid = ChessMove.createMove(from: blackKnightSq, to: ChessboardSquare(code: "h1")!.int8Value, on: board)!
        
        XCTAssertFalse(blackresults.contains(invalid) , "\(invalid) should not be be valid, becuase we have a black piece on that square")
           XCTAssert(blackresults.count == 5, "expected 5 move, got \(blackresults.count)")
        
    }

    
    func testValidKingMoves() {
        
        /*
         ♔
         ♖  ♘  ♗  ♕
         ♙
       */
        
          let boardStr =      """

                                        8   .  .  .  .  .  .  .  .
                                        7   .  *  *  *  .  .  .  .
                                        6   .  *  ♔  *  .  .  .  .
                                        5   .  *  *  *  .  .  .  .
                                        4   .  .  .  .  .  .  .  .
                                        3   .  .  .  .  .  .  .  .
                                        2   .  .  .  .  .  ♟  *  ♙
                                        1   .  .  .  .  .  *  ♚  *
                                            
                                            a  b  c  d  e  f  g  h

                                        """
                    
        var board = Chessboard(string: boardStr)!
        
        let whiteKingSq = ChessboardSquare(code: "c6")!.int8Value
        let blackKingSq = ChessboardSquare(code: "g1")!.int8Value
        
        
        assert(board[whiteKingSq]!.kind == .king)
        assert(board[blackKingSq]!.kind == .king)
        
        let validWhiteKingMoves = ["b5" , "b6","b6","c5", "c7","d5","d6", "d7"]
                                    .map{ ChessMove.createMove(from: whiteKingSq, to: ChessboardSquare(code: $0)!.int8Value, on: board)!}
        
        let validBlackKingMoves = ["f1" , "h1","g2","h2"]
                                        .map{ ChessMove.createMove(from: blackKingSq, to: ChessboardSquare(code: $0)!.int8Value, on: board)!}
        
        let whiteresults = validKingMoves(board: board, square: whiteKingSq)
        
        //whiteresults.contains(
        for move in validWhiteKingMoves {
            XCTAssert(whiteresults.contains(where:{ $0.from == move.from && $0.to == move.to } ), "\(move) should be valid")
        }
        XCTAssert(whiteresults.count == 8)
        
        board.toggleTurn()
        
        let blackresults = validKingMoves(board: board, square: blackKingSq)
           
           for move in validBlackKingMoves {
               XCTAssert(blackresults.contains(where:{ $0.from == move.from && $0.to == move.to }) , "\(move) should be valid")
           }
        
        let invalid = ChessMove.createMove(from: blackKingSq, to: ChessboardSquare(code: "f2")!.int8Value, on: board)!
        
        XCTAssertFalse(blackresults.contains(invalid) , "\(invalid) should not be be valid, becuase we have a black piece on that square")
           XCTAssert(blackresults.count == 4, "expected 3 move, got \(blackresults.count)")
        
    }
    
     func testValidPawnMoves() {
        // Not testing  enPassant here
        let chessString = """

                                   8   ♜  ♞  ♝  ♛  ♚  ♝  ♞  ♜
                                   7   ♟  ♟  ♟  .  ♟  ♟  .  ♟
                                   6   .  .  .  .  .  .  ♟  .
                                   5   .  .  .  ♟  .  .  .  .
                                   4   .  .  ♙  .  .  .  .  .
                                   3   .  .  .  .  .  .  .  .
                                   2   ♙  ♙  .  ♙  .  ♙  ♙  ♙
                                   1   ♖  ♘  ♗  ♕  ♔  ♗  ♘  ♖
                                       
                                       a  b  c  d  e  f  g  h

                               """
        var board = Chessboard(string: chessString)!
        //test white
        var moves = validPawnMoves(board: board, square: ChessboardSquare(code: "c4")!.int8Value)
        
        XCTAssert(moves.contains(ChessMove.createMove(from: ChessboardSquare(code: "c4")!.int8Value, to: ChessboardSquare(code: "c5")!.int8Value, on: board)!))
        XCTAssert(moves.contains(ChessMove.createMove(from: ChessboardSquare(code: "c4")!.int8Value, to: ChessboardSquare(code: "d5")!.int8Value, on: board)!))
        XCTAssertFalse(moves.contains(ChessMove.createMove(from: ChessboardSquare(code: "c4")!.int8Value, to: ChessboardSquare(code: "b5")!.int8Value, on: board)!)) //can't move dioahgonal if not taking
        XCTAssertFalse(moves.contains(ChessMove.createMove(from: ChessboardSquare(code: "c4")!.int8Value, to: ChessboardSquare(code: "c6")!.int8Value, on: board)!)) // can't move two unlesss first move
        
        
        moves = validPawnMoves(board: board, square: ChessboardSquare(code: "f2")!.int8Value)
        XCTAssert(moves.contains(ChessMove.createMove(from: ChessboardSquare(code: "f2")!.int8Value, to: ChessboardSquare(code: "f3")!.int8Value, on: board)!))
        XCTAssert(moves.contains(ChessMove.createMove(from: ChessboardSquare(code: "f2")!.int8Value, to: ChessboardSquare(code: "f4")!.int8Value, on: board)!))
        
        
     // test black
        board.toggleTurn()
        
        moves = validPawnMoves(board: board, square: ChessboardSquare(code: "d5")!.int8Value)
        
        XCTAssert(moves.contains(ChessMove.createMove(from: ChessboardSquare(code: "d5")!.int8Value, to: ChessboardSquare(code: "d4")!.int8Value, on: board)!))
        XCTAssert(moves.contains(ChessMove.createMove(from: ChessboardSquare(code: "d5")!.int8Value, to: ChessboardSquare(code: "c4")!.int8Value, on: board)!))
        XCTAssertFalse(moves.contains(ChessMove.createMove(from: ChessboardSquare(code: "d5")!.int8Value, to: ChessboardSquare(code: "e4")!.int8Value, on: board)!)) //can't move dioahgonal if not taking
        XCTAssertFalse(moves.contains(ChessMove.createMove(from: ChessboardSquare(code: "d5")!.int8Value, to: ChessboardSquare(code: "c3")!.int8Value, on: board)!)) // can't move two unlesss first move
        
        moves = validPawnMoves(board: board, square: ChessboardSquare(code: "g6")!.int8Value)
        XCTAssert(moves.contains(ChessMove.createMove(from: ChessboardSquare(code: "g6")!.int8Value, to: ChessboardSquare(code: "g5")!.int8Value, on: board)!))
        XCTAssertFalse(moves.contains(ChessMove.createMove(from: ChessboardSquare(code: "g6")!.int8Value, to: ChessboardSquare(code: "g4")!.int8Value, on: board)!)) // can't move two unlesss first move
        XCTAssertFalse(moves.contains(ChessMove.createMove(from: ChessboardSquare(code: "g6")!.int8Value, to: ChessboardSquare(code: "h5")!.int8Value, on: board)!))//can't move dioahgonal if not taking
    }
}


//
//  CastlingTests.swift
//  ChessTests
//
//  Created by David Crooks on 11/01/2020.
//  Copyright © 2020 david crooks. All rights reserved.
//

import XCTest
@testable import ChessEngine


class CastlingTests: XCTestCase {

    override func setUp() {
        /*

        ♜  ♞  ♝  ♛  ♚  ♝  ♞  ♜
        ♟  ♟  ♟  ♟  ♟  ♟  ♟  ♟
        .  .  .  .  .  .  .  .
        .  .  .  .  .  .  .  .
        .  .  .  .  .  .  .  .
        .  .  .  .  .  .  .  .
        ♙  ♙  ♙  ♙  ♙  ♙  ♙  ♙
        ♖  ♘  ♗  ♕  ♔  ♗  ♘  ♖

        */
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func  testCastleMove() {
        
        let castleString = """

                            ♜  .  .  .  ♚  .  .  ♜
                            ♟  ♟  ♟  .  .  ♟  ♟  ♟
                            .  .  .  .  .  .  .  .
                            .  .  .  .  .  .  .  .
                            .  .  .  .  .  .  .  .
                            .  .  .  .  .  .  .  .
                            ♙  ♙  ♙  .  .  ♙  ♙  ♙
                            ♖  .  .  .  ♔  .  .  ♖

                            """
        
        var board = Chessboard(string: castleString)!
        
        
       
        
        
        let whiteKingside = ChessMove(player: .white, castleingSide: .kingside, board: board)
        board = apply(move: whiteKingside, to: board)
        
        
        let blackKingside = ChessMove(player: .black, castleingSide: .kingside, board: board)
        board = apply(move: blackKingside, to: board)
        
        
        let expectedKingsideString = """

                            ♜  .  .  .  .  ♜  ♚  .
                            ♟  ♟  ♟  .  .  ♟  ♟  ♟
                            .  .  .  .  .  .  .  .
                            .  .  .  .  .  .  .  .
                            .  .  .  .  .  .  .  .
                            .  .  .  .  .  .  .  .
                            ♙  ♙  ♙  .  .  ♙  ♙  ♙
                            ♖  .  .  .  .  ♖  ♔  .

                            """
        
        let expectedKingsideBoard = Chessboard(string:expectedKingsideString)!
        
        XCTAssert(expectedKingsideBoard.same(as: board), "After castleing expected \(expectedKingsideString), but we got \n  \(board)")
        
       //start again
       board = Chessboard(string: castleString)!
       let whiteQueenside = ChessMove(player: .white, castleingSide: .queenside, board: board)
              
       board = apply(move: whiteQueenside, to: board)
    
       let blackQueenside = ChessMove(player: .black, castleingSide: .queenside, board: board)
       board = apply(move: blackQueenside, to: board)
       
       
       let expectedQueensideString = """

                           .  .  ♚  ♜  .  .  .  ♜
                           ♟  ♟  ♟  .  .  ♟  ♟  ♟
                           .  .  .  .  .  .  .  .
                           .  .  .  .  .  .  .  .
                           .  .  .  .  .  .  .  .
                           .  .  .  .  .  .  .  .
                           ♙  ♙  ♙  .  .  ♙  ♙  ♙
                           .  .  ♔  ♖  .  .  .  ♖

                           """
       
       let expectedQueensideBoard = Chessboard(string: expectedQueensideString)!
       
       XCTAssert(expectedQueensideBoard.same(as: board))
        
    }
    
    

    func testCanCastleKingsideWhenValid() {
        
        let canCastleString = """

                                ♜  .  ♝  ♛  ♚  .  .  ♜
                                ♟  ♟  ♟  ♟  ♝  ♟  ♟  ♟
                                .  .  ♞  .  .  ♞  .  .
                                .  ♗  .  .  ♟  .  .  .
                                .  .  .  .  ♙  .  .  .
                                .  .  .  .  .  ♘  .  .
                                ♙  ♙  ♙  ♙  .  ♙  ♙  ♙
                                ♖  ♘  ♗  ♕  ♔  .  .  ♖

                                """
        
        var board =  Chessboard(string: canCastleString)!
        let whitemove = ChessMove(player: .white,castleingSide: .kingside, board: board)
        XCTAssert(board.whosTurnIsItAnyway == .white)
        XCTAssert(isValid(move: whitemove, on: board))
       
        board = apply(move: whitemove, to: board)
        print("---------------------------------")
        XCTAssert(board.whosTurnIsItAnyway == .black)
        let blackmove = ChessMove(player: .black,castleingSide: .kingside, board: board)
        XCTAssert(isValid(move: blackmove, on: board))
        
    }
    
    
    func testCannotCastleOnAnEmptyBoard() {
        //ok, almost empty!
        let emptyBoard = """

                                .  .  .  .  .  .  .  .
                                .  .  .  .  ♔  .  .  .
                                .  .  .  .  .  .  .  .
                                .  .  .  .  .  .  .  .
                                .  .  .  .  .  .  .  .
                                .  .  ♚  .  .  .  .  .
                                .  .  .  .  .  .  .  .
                                .  .  .  .  .  .  .  .

                                """
        
        
        
        var board =  Chessboard(string: emptyBoard,toMove: .white)!
        var move = ChessMove(player: .white,castleingSide: .kingside, board: board)
        XCTAssertFalse(isValid(move: move, on: board))
        
        move = ChessMove(player: .white,castleingSide: .queenside, board: board)
        XCTAssertFalse(isValid(move: move, on: board))
        
        board =  Chessboard(string: emptyBoard,toMove: .black)!
        move = ChessMove(player: .black,castleingSide: .kingside, board: board)
        XCTAssertFalse(isValid(move: move, on: board))
        
        move = ChessMove(player: .black,castleingSide: .queenside, board: board)
        XCTAssertFalse(isValid(move: move, on: board))
        
        
        
    }
    
    func testCanCastleQueensideWhenValid() {
        
        let canCastleString = """

                                ♜  .  .  .  ♚  ♝  .  ♜
                                ♟  ♟  ♟  ♝  ♛  ♟  ♟  ♟
                                .  .  ♞  .  .  ♞  .  .
                                .  ♗  .  .  ♟  .  .  .
                                .  .  .  .  ♙  .  .  .
                                .  ♙  ♘  .  .  ♘  .  .
                                ♙  ♗  ♙  ♙  ♕  ♙  ♙  ♙
                                ♖  .  .  .  ♔  .  .  ♖

                                """
        var board =  Chessboard(string: canCastleString)!
        
        let whitemove = ChessMove(player: .white,castleingSide: .queenside, board: board)
        XCTAssert(isValid(move: whitemove, on: board))
        
        board = apply(move: whitemove, to: board)
        
        let blackmove = ChessMove(player: .black,castleingSide: .queenside, board: board)
        XCTAssert(isValid(move: blackmove, on: board))
        
    }
    
    
    func testCannotCastleIfOppenentControlsSpace() {
        let bishopControls = """

                                    ♜  .  .  ♛  ♚  ♝  .  ♜
                                    ♟  .  ♟  ♟  .  ♟  ♟  ♟
                                    ♝  .  ♟  .  .  ♞  .  .
                                    .  .  .  .  ♟  .  .  .
                                    .  .  .  .  ♙  .  .  .
                                    .  .  ♘  .  .  ♘  .  .
                                    ♙  ♙  ♙  ♙  .  ♙  ♙  ♙
                                    ♖  ♘  ♗  ♕  ♔  .  .  ♖

                                    """
        
        
        let board =  Chessboard(string: bishopControls )!
               
        let move = ChessMove(player: .white, castleingSide: .kingside, board: board)
        
        XCTAssertFalse(isValid(move: move, on: board),"Cannont castle when an oppent controls the space between the king and rook")
    }
    
    func testCannotCastleIfAlreadyMoved() {
        let canCastleString = """

                                ♜  .  ♝  ♛  ♚  .  .  ♜
                                ♟  ♟  ♟  ♟  ♝  ♟  ♟  ♟
                                .  .  ♞  .  .  ♞  .  .
                                .  ♗  .  .  ♟  .  .  .
                                .  .  .  .  ♙  .  .  .
                                .  .  .  .  .  ♘  .  .
                                ♙  ♙  ♙  ♙  .  ♙  ♙  ♙
                                ♖  ♘  ♗  ♕  ♔  .  .  ♖

                                a  b  c  d  e  f  g  h
                                """
        let initialBoard =          Chessboard(string: canCastleString)!
        var board =                 Chessboard(string: canCastleString)!
        
        
        XCTAssertTrue(board.castelState.whiteCanCastleKingside)
        XCTAssertTrue(board.castelState.blackCanCastleKingside)
        //XCTAssertFalse(board.castelState.blackCanCastleQueenside)
        //XCTAssertFalse(board.castelState.whiteCanCastleQueenside)
        
        let whiteMovesKing =        Move(code: "e1->e2")!
        let blackMovesRook =        Move(code: "h8-g8")!
        let whiteMovesKingBack =    Move(code: "e2->e1")!
        let blackMovesRookBack =    Move(code: "g8->h8")!
        print("---------------------")
        print("white moves king---")
        board = apply(move: whiteMovesKing, to: board)!
        print("black moves rook---")
        board = apply(move: blackMovesRook, to: board)!
        
        print("---------------------")
        print("white moves king back---")
        board = apply(move: whiteMovesKingBack, to: board)!
        print("black moves rook back---")
        board = apply(move: blackMovesRookBack, to: board)!
        
        XCTAssert(board.same(as: initialBoard),"All the pieces should be back where they where")
        
        
        //the board looks the same but niether side can castle now:
        XCTAssertFalse(board.castelState.whiteCanCastleKingside)
        XCTAssertFalse(board.castelState.whiteCanCastleQueenside)
        XCTAssertFalse(board.castelState.blackCanCastleKingside)
        //It's not a valid move right now, but black still has the right to castle on the queenside
        XCTAssertTrue(board.castelState.blackCanCastleQueenside)
        
        
        
        
        
        let whitecastles = ChessMove(player: .white,castleingSide: .kingside, board: board)
        XCTAssertFalse(isValid(move: whitecastles, on: board),"Cannot castle after moveing king")
        
        board = apply(move:whiteMovesKing, to: board)!
        
       
        
        let blackcastles = ChessMove(player: .black,castleingSide: .kingside, board: board)
        XCTAssertFalse(isValid(move:blackcastles, on: board),"Cannot castle after moveing rook")
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

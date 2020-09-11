//
//  EnPassantTests.swift
//  ChessTests
//
//  Created by David Crooks on 11/01/2020.
//  Copyright © 2020 david crooks. All rights reserved.
//

import XCTest
@testable import ChessEngine

class EnPassantTests: XCTestCase {

    override func setUp() {
      
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanTakeEnPassantWhenValid() {
        let chessString = """

                            8   ♜  ♞  ♝  ♛  ♚  ♝  ♞  ♜
                            7   ♟  ♟  ♟  ♟  ♟  ♟  .  ♟
                            6   .  .  .  .  .  .  .  .
                            5   .  .  .  .  .  .  ♟  .
                            4   .  .  ♙  .  .  .  .  .
                            3   .  .  .  .  .  .  .  .
                            2   ♙  ♙  .  ♙  ♙  ♙  ♙  ♙
                            1   ♖  ♘  ♗  ♕  ♔  ♗  ♘  ♖
                                
                                a  b  c  d  e  f  g  h

                        """
        
        
        guard let startboard = Chessboard(string:chessString) else {
            XCTFail("Failed to load chessboard")
            return
        }
        
        let whitePawnAdvances =             Move(code:"c4->c5")!
        let blackMovesPawnTwoSpaces =       Move(code:"d7->d5")!
        let whiteTakesEnPassant     =       Move(code:"c5->d6")!
        
        let blackPawnAdvances     =         Move(code:"g5->g4")!
        let whiteMovesPawnTwoSpaces =       Move(code:"f2->f4")!
        let blackTakesEnPassant     =       Move(code:"g4->f3")!
        
        var chessboard = startboard
        
        chessboard = apply(move:whitePawnAdvances,    to: chessboard)!
        chessboard = apply(move:blackMovesPawnTwoSpaces,    to: chessboard)!
        
        let whiteTakesEnPassantValidated = validate(chessboard: chessboard, move: whiteTakesEnPassant);
       
        XCTAssertNotNil(whiteTakesEnPassantValidated, "White should be able to take enpassant here")
        
        chessboard = apply(move:whiteTakesEnPassant ,    to: chessboard)!
        chessboard = apply(move:blackPawnAdvances,                                       to: chessboard)!
        chessboard = apply(move:whiteMovesPawnTwoSpaces,                                 to: chessboard)!
        
        
        let blackTakesEnPassantValidated = validate(chessboard: chessboard, move: blackTakesEnPassant);
        XCTAssertNotNil(blackTakesEnPassantValidated, "Black should be able to take enpassant here")
        
        
        chessboard = apply(move:blackTakesEnPassant,     to: chessboard)!
        
        let expectedBoardString = """

                                    ♜  ♞  ♝  ♛  ♚  ♝  ♞  ♜
                                    ♟  ♟  ♟  .  ♟  ♟  .  ♟
                                    .  .  .  ♙  .  .  .  .
                                    .  .  .  .  .  .  .  .
                                    .  .  .  .  .  .  .  .
                                    .  .  .  .  .  ♟  .  .
                                    ♙  ♙  .  ♙  ♙  .  ♙  ♙
                                    ♖  ♘  ♗  ♕  ♔  ♗  ♘  ♖

                                    """
        
        let expectedBoard = Chessboard(string: expectedBoardString)
        
        XCTAssert(chessboard.same(as: expectedBoard!), "This: \n\n \(chessboard) \n\n is not the boad we expected.");
    }
    
    func testCannotTakeEnPassantUnlessJustMoved() {
        let chessString = """

                           ♜  ♞  ♝  ♛  ♚  ♝  ♞  ♜
                           ♟  ♟  ♟  ♟  ♟  ♟  .  ♟
                           .  .  .  .  .  .  .  .
                           .  .  ♙  .  .  .  ♟  .
                           .  .  .  .  .  .  .  .
                           .  .  .  .  .  .  .  .
                           ♙  ♙  .  ♙  ♙  ♙  ♙  ♙
                           ♖  ♘  ♗  ♕  ♔  ♗  ♘  ♖

                           """
       // black to move
     
        guard let startboard = Chessboard(string:chessString, toMove:.black) else {
           XCTFail("Failed to load chessboard")
           return
       }
       
       let blackMovesPawnTwoSpaces  =    Move(code:"d7->d5")!
       let irrelevantWhiteMove      =    Move(code:"h2->h3")!
       let irrelevantBlackMove      =    Move(code:"h7->h6")!
        
       let whiteTakesEnPassant      =    Move(code:"c5->d6")!
       
       var chessboard = startboard
       
       chessboard = apply(move:blackMovesPawnTwoSpaces, to: chessboard)!
       chessboard = apply(move:irrelevantWhiteMove,     to: chessboard)!
       chessboard = apply(move:irrelevantBlackMove,     to: chessboard)!
       
       XCTAssertFalse(isValid(move:whiteTakesEnPassant, on:chessboard), "White should not be able to take enpassant, as the black piece to take did not move last turn")
       
           
    }
    
    func testCannotTakeEnPassantWhenInvalid() {
        let chessString = """

                        ♜  ♞  ♝  ♛  ♚  ♝  ♞  ♜
                        ♟  ♟  ♟  .  ♟  ♟  .  ♟
                        .  .  .  .  .  .  .  .
                        .  .  .  ♟  .  .  ♟  .
                        .  .  ♙  .  .  .  .  .
                        .  ♙  .  .  .  .  .  .
                        ♙  .  .  ♙  ♙  ♙  ♙  ♙
                        ♖  ♘  ♗  ♕  ♔  ♗  ♘  ♖

                        """
        // black to move
        var chessboard = Chessboard(string:chessString,toMove:PlayerColor.black)!
        
        let blackPawnMovesPastWhite = Move(code: "d5->d4")!
        let whiteTriesToTakeInvalidEnPassant = Move(code: "c4->d5")!
        
        XCTAssert(chessboard.whosTurnIsItAnyway == .black,"It should be blacks move, test is broken")
        chessboard = apply(move: blackPawnMovesPastWhite, to: chessboard)!
        
        XCTAssert(chessboard.whosTurnIsItAnyway == .white,"It should be whites move, test is broken")
        XCTAssertFalse(isValid(move:whiteTriesToTakeInvalidEnPassant, on:chessboard), "White Pawn should be able to take en passant here")
        
    }
    
    func testCannotMoveDiagonallyWhenNotTaking() {
        let chessString = """

                        ♜  ♞  ♝  ♛  ♚  ♝  ♞  ♜
                        ♟  ♟  ♟  ♟  ♟  ♟  .  ♟
                        .  .  .  .  .  .  .  .
                        .  .  .  .  .  .  ♟  .
                        .  .  ♙  .  .  .  .  .
                        .  .  .  .  .  .  .  .
                        ♙  ♙  .  ♙  ♙  ♙  ♙  ♙
                        ♖  ♘  ♗  ♕  ♔  ♗  ♘  ♖

                        """
        
        var chessboard = Chessboard(string:chessString)!
        
        let whiteMovesDiagonal = Move(code: "c4->d5")!
        let blackMovesDiagonal = Move(code: "g5->f4")!
        
        XCTAssert(chessboard.whosTurnIsItAnyway == .white,"It should be whites move, test is broken")
        XCTAssertFalse(isValid(move:whiteMovesDiagonal, on:chessboard), "White Pawn should not be able to move diagonally except when taking en passant")
        
        //
        let whiteMovesForward = Move(code: "c4->c5")!
        chessboard = apply(move: whiteMovesForward, to: chessboard)!
        
        XCTAssert(chessboard.whosTurnIsItAnyway == .black,"It should be blacks move, test is broken")
        XCTAssertFalse(isValid(move:blackMovesDiagonal, on:chessboard), "Black Pawn should not be able to move diagonally except when taking en passant")
        
        
        
    }
    
    //TODO: Add tests whith role of white and black reversed!
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

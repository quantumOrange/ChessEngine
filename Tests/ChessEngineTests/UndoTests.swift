//
//  UndoTests.swift
//  ChessTests
//
//  Created by David Crooks on 29/03/2020.
//  Copyright © 2020 david crooks. All rights reserved.
//

import XCTest
@testable import ChessEngine

class UndoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUndo() throws {
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
            board = apply(move: move, to: board)!
            XCTAssert(board.whosTurnIsItAnyway ==  (board.moves.count.isMultiple(of: 2) ? .white : .black))
        }
        print(board)
        XCTAssertFalse(board.same( as: Chessboard.start() ))
        //white cannot castle because they moved the king
        XCTAssertFalse(board.castelState.contains(.whiteCanCastleKingside))
        XCTAssertFalse(board.castelState.contains(.whiteCanCastleQueenside))
        
        //black cannot castle kingside because they moved the rook
        XCTAssertFalse(board.castelState.contains(.blackCanCastleKingside))
        
        //black still has the right to caste queenside
        XCTAssert(board.castelState.contains(.blackCanCastleQueenside))
        
        XCTAssert(board.takenPieces.count == 3)
        if let piece = board.takenPieces.last {
            XCTAssert(piece.kind == .bishop)
            XCTAssert(piece.player == .black)
        }
        else
        {
            XCTAssert(false, "No piece taken. The last piece taken should have been a black bishop.")
        }
        
        //Undo all the moves
        for _ in 0...moves.count {
            _ = board.undo()
             XCTAssert(board.whosTurnIsItAnyway ==  (board.moves.count.isMultiple(of: 2) ? .white : .black))
        }
        
       
        
        //cannot undo anymore - we are back to the beginning
        XCTAssertFalse(board.undo())
        // So the pieces should be in there start poitions
        XCTAssert(board.same( as: Chessboard.start() ))
        XCTAssert(board.takenPieces.isEmpty)
        
        //Castle state restored to initial state - both players can castle on both sides
        XCTAssert(board.castelState.contains(.whiteCanCastleKingside))
        XCTAssert(board.castelState.contains(.blackCanCastleKingside))
        XCTAssert(board.castelState.contains(.whiteCanCastleQueenside))
        XCTAssert(board.castelState.contains(.blackCanCastleQueenside))
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testRedo() throws {
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
            board = apply(move: move, to: board)!
            XCTAssert(board.whosTurnIsItAnyway ==  (board.moves.count.isMultiple(of: 2) ? .white : .black))
        }
        print(board)
        
        XCTAssertFalse(board.same( as: Chessboard.start() ))
        
        let endBoard = board
        let numUndos = moves.count
        
        //Undo all the moves
        for _ in 0...numUndos {
            _ = board.undo()
        }
        
        // So the pieces should now be in there start positions
        XCTAssert(board.same( as: Chessboard.start() ))
        
        //Redo all the moves
        for _ in 0...numUndos {
            _ = board.redo()
        }
        
        XCTAssert(board.same( as: endBoard ))
        
    }
    
    func testCantRedoAfterMove() throws {
        let moves:[Move] = [
                                    Move(code:"e2->e4")!,
                                    Move(code:"e7->e6")!,
                                    Move(code:"f1->c4")!,
                                    Move(code:"h7->h6")!,
                                    Move(code:"d1->f3")!,
                                    Move(code:"f8->a3")!,
                                    Move(code:"b2->b3")!,
                                    Move(code:"a3->c1")!,
                                ]
        
        var  board = Chessboard.start()
        
        for move in moves {
            board = apply(move: move, to: board)!
            XCTAssert(board.whosTurnIsItAnyway ==  (board.moves.count.isMultiple(of: 2) ? .white : .black))
        }
        
        
        //Undo some moves
        let numUndos = 6
        
        for _ in 0..<numUndos {
            _ = board.undo()
        }
        
        //We should have six redos available
        XCTAssert(board.redoableMoves.count == numUndos)
        
        //Then we make a move ...
        let move  = Move(code:"b1->c3")!
        board = apply(move: move, to: board)!
       
        //After making a move, redos are no longer valid and should be discarded:
        let newBoard = board
        let success = board.redo()
        
        XCTAssert(board.redoableMoves.count == 0) // check we have discareded all redos
        XCTAssertFalse(success) // check redo returns false
        XCTAssert(newBoard.same(as: board)) //check redo did nothing
        
    }

    func testPerformanceExample() throws {
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
        
        
        // This is an example of a performance test case.
        self.measure {
            for move in moves {
                board = apply(move: move, to: board)!
                
            }
            
            //Undo all the moves
            for _ in 0...moves.count {
                _ = board.undo()
            }
            
            // Put the code you want to measure the time of here.
        }
    }

}

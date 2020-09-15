//
//  ValidMovesPerformance.swift
//  ChessTests
//
//  Created by David Crooks on 06/04/2020.
//  Copyright © 2020 david crooks. All rights reserved.
//

import XCTest
@testable import ChessEngine

class ValidMovesPerformance: XCTestCase {
var developedBoard:Chessboard!
    override func setUpWithError() throws {
        let boardStr =      """

             8   ♜  ♞  ♝  .  ♚  .  ♞  ♜
             7   ♟  ♟  ♟  ♟  .  ♟  ♟  ♟
             6   .  .  .  .  .  .  .  .
             5   .  .  ♝  .  ♟  .  .  .
             4   .  .  .  .  ♙  .  .  ♛
             3   .  ♙  ♘  .  .  .  .  .
             2   ♙  ♗  ♙  ♙  .  ♙  ♙  ♙
             1   ♖  .  .  ♕  ♔  ♗  ♘  ♖

                 a  b  c  d  e  f  g  h
            """
        
        developedBoard = Chessboard(string: boardStr)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   

    func testPerformanceValidMoves() {
            self.measure {
                let _ = validMoves(chessboard: developedBoard)
            }
        }

    func testPerformanceUncheckedValidMoves() {
            self.measure {
                for _ in 1...1000 {
                let _ = uncheckedValidMoves(chessboard:developedBoard)
                }
            }
        }

       
        func testPerformancValidPawnMoves()
        {
            
            let boardStr = """

                        .  .  .  .  .  .  .  .
                        .  .  .  .  .  .  .  .
                        .  .  .  .  .  .  .  .
                        .  .  .  .  .  .  .  .
                        .  .  .  ♙  .  .  .  .
                        .  .  .  .  .  .  .  .
                        .  .  .  .  .  .  .  .
                        .  .  .  .  .  .  .  .

            """
            
            let board = Chessboard(string: boardStr)!
            
            
            let square = ChessboardSquare(code: "d4")!
            
            assert(board[square]!.kind == .pawn)
            
            
            let board2 = Chessboard.start()
            let squares:[ChessboardSquare] = [ .a2, .b2,.c2, .d2,.e2,.f2,.g2,.h2]
            
            
            self.measure
            {
                
                for _ in 1...10000 {
                    for sq in squares {
                        let _ = validPawnMoves(board:board, square: square.int8Value)
                        let _ = validPawnMoves(board:board2, square: sq.int8Value)
                        
                    }
                }
            }
        }
        
        func testPerformancValidRookMoves() {
            /*
            ♔
            ♖  ♘  ♗  ♕
            ♙
            */
            let boardStr = """

                                   .  .  .  .  .  .  .  .
                                   .  .  .  .  .  .  .  .
                                   .  .  .  .  .  .  .  .
                                   .  .  .  .  .  .  .  .
                                   .  .  .  ♖  .  .  .  .
                                   .  .  .  .  .  .  .  .
                                   .  .  .  .  .  .  .  .
                                   .  .  .  .  .  .  .  .

                       """
                       
           let board = Chessboard(string: boardStr)!
           
           let square = ChessboardSquare(code: "d4")!
           
           assert(board[square]!.kind == .rook)
            
            self.measure
            {
              
                let _ = validRookMoves(board:board, square: square.int8Value)
                    
            }
               
        }
        
        func testPerformancValidKingMoves() {
        /*
           ♔
           ♖  ♘  ♗  ♕
           ♙
           */
           let boardStr = """

                                  .  .  .  .  .  .  .  .
                                  .  .  .  .  .  .  .  .
                                  .  .  .  .  .  .  .  .
                                  .  .  .  .  .  .  .  .
                                  .  .  .  ♔  .  .  .  .
                                  .  .  .  .  .  .  .  .
                                  .  .  .  .  .  .  .  .
                                  .  .  .  .  .  .  .  .

                      """
                      
          let board = Chessboard(string: boardStr)!
          
          let square = ChessboardSquare(code: "d4")!
          
          assert(board[square]!.kind == .king)
            self.measure {
                
                         let _ = validKingMoves(board:board, square: square.int8Value)
                   
                }
               
            
        }
        
        func testPerformancValidBishopMoves() {
            /*
            ♔
            ♖  ♘  ♗  ♕
            ♙
            */
        let boardStr = """

                                .  .  .  .  .  .  .  .
                                .  .  .  .  .  .  .  .
                                .  .  .  .  .  .  .  .
                                .  .  .  .  .  .  .  .
                                .  .  .  ♗  .  .  .  .
                                .  .  .  .  .  .  .  .
                                .  .  .  .  .  .  .  .
                                .  .  .  .  .  .  .  .

                    """
                    
        let board = Chessboard(string: boardStr)!
        
        let square = ChessboardSquare(code: "d4")!
        
        assert(board[square]!.kind == .bishop)
            
            self.measure {
                    let _ = validBishopMoves(board:board, square: square.int8Value)
            }
        }
        
        func testPerformancValidKnightMoves() {
            
            let boardStr = """

                                           .  .  .  .  .  .  .  .
                                           .  .  .  .  .  .  .  .
                                           .  .  .  .  .  .  .  .
                                           .  .  .  .  .  .  .  .
                                           .  .  .  ♘  .  .  .  .
                                           .  .  .  .  .  .  .  .
                                           .  .  .  .  .  .  .  .
                                           .  .  .  .  .  .  .  .

                               """
                               
                   let board = Chessboard(string: boardStr)!
                   
                   let square = ChessboardSquare(code: "d4")!
                   
                   assert(board[square]!.kind == .knight)
            
            self.measure {
                
                    let _ = validKnightMoves(board:board, square: square.int8Value)
                
               
            }
        }
        
        func testPerformancValidQueenMoves() {
            
            let boardStr = """

                                           .  .  .  .  .  .  .  .
                                           .  .  .  .  .  .  .  .
                                           .  .  .  .  .  .  .  .
                                           .  .  .  .  .  .  .  .
                                           .  .  .  ♕  .  .  .  .
                                           .  .  .  .  .  .  .  .
                                           .  .  .  .  .  .  .  .
                                           .  .  .  .  .  .  .  .

                               """
                               
                   let board = Chessboard(string: boardStr)!
            
            
            let boardStr1 = """

                                    .  .  .  .  .  .  .  .
                                    .  .  .  .  .  .  .  .
                                    .  .  .  .  .  .  .  .
                                    .  .  .  .  .  .  .  .
                                    .  .  .  .  .  .  .  .
                                    .  .  .  .  .  .  .  .
                                    .  .  .  .  .  .  .  .
                                    ♕  .  .  .  .  .  .  .

                        """
                        
            let board1 = Chessboard(string: boardStr1)!
            
            
            let boardStr2 = """

                                    .  .  .  .  .  .  .  .
                                    .  .  .  .  .  .  .  .
                                    .  .  .  .  .  ♘  .  .
                                    .  .  .  .  .  .  .  .
                                    .  .  .  ♕  .  .  .  ♘
                                    .  .  .  .  .  .  .  .
                                    .  .  .  .  .  .  .  .
                                    .  .  .  .  .  .  .  .

                        """
                        
            let board2 = Chessboard(string: boardStr2)!
                   
                   let square = ChessboardSquare(code: "d4")!
                   let square1 = ChessboardSquare(code: "a1")!
                   assert(board[square]!.kind == .queen)
                    assert(board1[square1]!.kind == .queen)
                    assert(board2[square]!.kind == .queen)
            
            self.measure {
                for _ in 0...100 {
                    let _ = validQueenMoves(board:board, square: square.int8Value)
                    let _ = validQueenMoves(board:board1, square: square1.int8Value)
                    let _ = validQueenMoves(board:board2, square: square1.int8Value)
                }
            }
        }
       
}

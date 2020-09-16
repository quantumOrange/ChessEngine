//
//  MinMaxChessEnginteTests.swift
//  ChessTests
//
//  Created by David Crooks on 13/10/2019.
//  Copyright © 2019 david crooks. All rights reserved.
//

import XCTest
@testable import ChessEngine

class MinMaxChessEnginteTests: XCTestCase {

    override func setUp() {
       /*
         
         let puzzel1 =      """

                            8   ♜  ♞  ♝  ♛  ♚  ♝  ♞  ♜
                            7   ♟  ♟  ♟  ♟  ♟  ♟  ♟  ♟
                            6   .  .  .  .  .  .  .  .
                            5   .  .  .  .  .  .  .  .
                            4   .  .  .  .  .  .  .  .
                            3   .  .  .  .  .  .  .  .
                            2   ♙  ♙  ♙  ♙  ♙  ♙  ♙  ♙
                            1   ♖  ♘  ♗  ♕  ♔  ♗  ♘  ♖
                                
                                a  b  c  d  e  f  g  h

                            """
         
         let solution1 = "->"
         
        
         */
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    
    func checkPuzzel(puzzel:String,toMove:PlayerColor = .white, solution:String, depth:Int = 2) -> Bool
    {
        guard let board = Chessboard(string:puzzel,toMove: toMove),
            let bestMove = Move(code:solution ),
        let validatedSolution = validate(chessboard: board, move: bestMove)
            else  {
            print( "Your suggested soulution \(solution) is  not even valid on \(puzzel) you fool. " )
            return false
        }
        
        //let _ = miniMaxRoot(for: board, depth: 2, isMaximisingPlayer: true)
        if let move = pickMoveMiniMax(for: board, depth:depth)
        {
            let correct = ( move == validatedSolution )
            if !correct {
                print( "\(move) is not the best move on \n \(board) \n best move was \(validatedSolution)" )
            }
            return correct
        }
        else {
            print( "no move found" )
        }
        return false
    }
    
    func nottestSimpleEndgamePuzzels() {
        /*
        ♚
        ♜  ♞  ♝  ♛
        ♟
        ♔
        ♖  ♘  ♗  ♕
        ♙
        */
        
       
        
        let puzzel1 =      """

                        8   .  .  .  .  .  .  .  ♚
                        7   .  .  .  .  .  .  .  .
                        6   .  .  .  .  .  .  .  .
                        5   .  .  .  .  ♜  .  .  .
                        4   .  .  .  .  .  .  .  .
                        3   .  .  .  ♘  .  .  .  .
                        2   .  ♙  .  .  .  .  .  .
                        1   ♔  .  .  .  .  .  .  .
                            
                            a  b  c  d  e  f  g  h

        """
        //white to move
        let solution1 = "d3->e5"
        
        let puzzel2 =      """

                        8   .  .  .  .  .  .  .  .
                        7   .  .  .  .  .  .  ♚  .
                        6   .  .  .  .  .  .  .  .
                        5   .  .  .  .  ♖  .  .  ♟
                        4   .  .  .  ♝  .  .  .  .
                        3   .  ♙  .  .  .  .  .  .
                        2   .  .  ♔  .  .  .  .  .
                        1   .  .  .  .  .  .  .  .
                            
                            a  b  c  d  e  f  g  h

        """
        //black to move
        let solution2 = "d4->e5"
        
        
        
        let puzzel3 =      """

                               8   ♚  .  .  .  .  .  .  .
                               7   .  .  .  .  .  .  .  .
                               6   .  .  .  .  .  .  ♙  .
                               5   .  .  .  .  .  .  .  .
                               4   .  .  .  .  .  .  .  .
                               3   ♟  .  .  .  .  .  .  .
                               2   .  .  .  .  .  .  .  .
                               1   .  .  .  .  .  .  .  ♔
                                   
                                   a  b  c  d  e  f  g  h

               """
                //black or white to move
        let solution3forWhite = "g6->g7"
        let solution3forBlack = "a3->a2"
        
       
        
        let puzzel4 =      """

                           8    .  .  .  ♚  .  .  .  .
                           7    .  .  .  .  .  .  .  .
                           6    ♙  .  .  .  .  .  .  .
                           5    .  .  .  .  ♟  .  .  .
                           4    .  .  .  .  .  .  .  .
                           3    .  .  .  .  .  .  .  .
                           2    .  .  .  .  .  .  .  .
                           1    .  .  .  .  ♔  .  .  .
                               
                                a  b  c  d  e  f  g  h

                           """
        //white tyo move
        let solution4 = "a6->a7"
        
        
        
        let puzzel5 =      """

                                   8   .  .  .  ♜  .  .  .  ♚
                                   7   .  .  .  .  .  .  .  .
                                   6   .  .  .  .  ♞  .  .  ♟
                                   5   .  .  .  ♙  ♘  .  .  .
                                   4   .  ♟  ♙  .  .  .  .  .
                                   3   .  .  .  .  .  .  .  .
                                   2   .  .  .  .  .  .  .  .
                                   1   .  .  .  ♖  .  ♔  .  .
                                       
                                       a  b  c  d  e  f  g  h

                                   """
        let solution5 = "e5->f7"
        
        
        let puzzel6 = """

                               8   .  .  .  .  .  .  .  .
                               7   .  ♟  .  .  .  .  .  .
                               6   ♙  .  ♘  .  .  .  .  .
                               5   .  .  .  .  .  .  .  .
                               4   .  .  ♔  .  .  .  .  ♚
                               3   .  .  .  .  .  .  .  .
                               2   .  .  .  .  .  .  .  .
                               1   .  .  .  .  .  .  .  ♞
                                   
                                   a  b  c  d  e  f  g  h

                       """
               //black to move
               let solution6 = "b7->a6"
        
        
        let puzzel7 =      """

                                   8   .  .  .  .  .  .  .  ♚
                                   7   ♖  .  .  .  .  .  .  .
                                   6   .  .  .  .  .  .  .  .
                                   5   .  .  .  .  .  .  .  .
                                   4   .  ♖  .  .  .  .  .  .
                                   3   .  .  .  .  .  .  .  .
                                   2   .  .  .  .  ♜  .  .  ♟
                                   1   .  .  ♔  .  .  .  .  .
                                       
                                       a  b  c  d  e  f  g  h

                                   """
        //white to move
        let solution7 = "b4->b8"
        
        var depth = 2;
        print("-------------- 1. --------------------")
        XCTAssertTrue(checkPuzzel(puzzel:puzzel1, toMove:.white, solution:solution1,            depth:depth), "failed for \n \(puzzel1)")
        print("-------------- 2. --------------------")
        XCTAssertTrue(checkPuzzel(puzzel:puzzel2, toMove:.black, solution:solution2 ,           depth:depth), "failed for \n \(puzzel2)")
        
        
        print("-------------- 3.white --------------------")
        XCTAssertTrue(checkPuzzel(puzzel:puzzel3, toMove:.white, solution:solution3forWhite ,   depth:depth), "failed for \n \(puzzel3)")
        print("-------------- 3.black --------------------")
        XCTAssertTrue(checkPuzzel(puzzel:puzzel3, toMove:.black, solution:solution3forBlack ,   depth:depth), "failed for \n \(puzzel3)")
        
         depth = 3;
         print("-------------- 4 --------------------")
         XCTAssertTrue(checkPuzzel(puzzel:puzzel4, toMove:.white, solution:solution4 ,           depth:depth), "failed for \n \(puzzel4)")
        print("-------------- 5 --------------------")
         depth = 4;
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel5, toMove:.white, solution:solution5 ,           depth:depth), "failed for \n \(puzzel5)")
        print("-------------- 6 --------------------")
        
        //depth = 6;
        XCTAssertTrue(checkPuzzel(puzzel:puzzel6, toMove:.black, solution:solution6 ,           depth:depth), "failed for \n \(puzzel6)")
        
        depth = 2;
        print("-------------- 7 --------------------")
         XCTAssertTrue(checkPuzzel(puzzel:puzzel7, toMove:.white, solution:solution7 ,           depth:depth), "failed for \n \(puzzel7)")
         
        
    }
    
    func nottestTrivialPuzzels() {
        
        print(Chessboard.start().evaluate())
        let puzzel1 = """

                        8   ♜  ♞  ♝  .  ♚  ♝  ♞  ♜
                        7   ♟  .  ♟  ♟  .  ♟  ♟  ♟
                        6   .  ♟  .  .  ♟  .  .  .
                        5   .  .  .  .  .  .  ♛  .
                        4   .  .  .  .  .  .  .  .
                        3   .  .  .  ♙  .  .  .  .
                        2   ♙  ♙  ♙  .  ♙  ♙  ♙  ♙
                        1   ♖  ♘  ♗  ♕  ♔  ♗  ♘  ♖
                            
                            a  b  c  d  e  f  g  h

                """
        
        let solution1 = "c1->g5"
        
        let puzzel2 =      """

                           8    ♜  ♞  ♝  .  ♚  ♝  ♞  ♜
                           7    ♟  ♟  ♟  ♟  .  ♟  ♟  ♟
                           6    .  .  .  .  .  .  .  .
                           5    .  .  .  .  ♟  .  ♛  .
                           4    .  .  .  .  .  .  .  .
                           3    .  .  ♘  .  .  ♘  .  .
                           2    ♙  ♙  ♙  ♙  ♙  ♙  ♙  ♙
                           1    ♖  .  ♗  ♕  ♔  ♗  .  ♖
                               
                                a  b  c  d  e  f  g  h

                           """
        
        let solution2 = "f3->g5"
        
        
        let puzzel3 =               """

                          8   ♜  ♞  ♝  ♛  ♚  .  ♞  ♜
                          7   ♟  ♟  ♟  ♟  ♟  ♟  ♝  ♟
                          6   .  .  .  .  .  .  ♟  .
                          5   .  .  .  .  .  .  .  .
                          4   .  ♙  .  .  .  .  .  .
                          3   ♘  .  .  .  .  .  .  .
                          2   ♙  .  ♙  ♙  ♙  ♙  ♙  ♙
                          1   ♖  .  ♗  ♕  ♔  ♗  ♘  ♖
                              
                              a  b  c  d  e  f  g  h

                          """
        
        let solution3 = "g7->a1"
        
        let puzzel4 =      """

                           8    ♜  .  .  ♛  ♚  ♝  .  ♜
                           7    ♟  .  ♟  .  .  ♟  ♟  ♟
                           6    ♝  ♟  ♞  .  ♟  ♞  .  .
                           5    .  .  .  ♟  .  .  .  .
                           4    .  .  .  .  ♙  .  .  ♙
                           3    .  .  .  .  .  ♘  ♙  ♗
                           2    ♙  ♙  ♙  ♙  ♕  ♙  .  .
                           1    ♖  ♘  ♗  .  .  ♖  ♔  .
                               
                                a  b  c  d  e  f  g  h

                           """
        
        let solution4 = "a6->e2"
        let depth = 2
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel1,solution:solution1 , depth:depth), "failed for \n \(puzzel1)")
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel2,solution:solution2 , depth:depth), "failed for \n \(puzzel2)")
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel3, toMove:.black, solution:solution3 , depth:depth), "failed for \n \(puzzel3)")
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel4, toMove:.black, solution:solution4 , depth:depth), "failed for \n \(puzzel4)")
    }
    
    func nottestCheckmatePuzzels() {
        let puzzel1 =      """

                           8   ♜  .  ♝  ♛  ♚  .  ♞  ♜
                           7   ♟  .  ♟  ♟  .  ♟  ♟  ♟
                           6   .  ♟  ♞  .  .  .  .  .
                           5   .  .  .  .  ♟  .  ♘  .
                           4   .  ♝  .  .  ♙  .  .  .
                           3   .  .  .  .  .  ♕  .  .
                           2   ♙  ♙  ♙  ♙  .  ♙  ♙  ♙
                           1   ♖  ♘  ♗  .  ♔  ♗  .  ♖

                               a  b  c  d  e  f  g  h

                           """
        
        let solution1 = "f3->f7"
        
        let puzzel2 = """

                              8   ♜  .  ♝  ♛  ♚  ♝  ♞  ♜
                              7   .  ♟  ♟  ♟  .  ♟  ♟  ♟
                              6   ♟  .  ♞  .  .  .  .  .
                              5   .  .  .  .  ♟  .  .  ♕
                              4   .  .  ♗  .  ♙  .  .  .
                              3   .  .  .  .  .  .  .  .
                              2   ♙  ♙  ♙  ♙  .  ♙  ♙  ♙
                              1   ♖  ♘  ♗  .  ♔  .  ♘  ♖
                                  
                                  a  b  c  d  e  f  g  h

                          """
                      
                      let solution2 = "h5->f7"
        
        let puzzel3 =      """

                                8   ♜  ♞  ♝  .  ♜  .  ♚  .
                                7   ♟  ♟  ♟  ♟  .  ♟  ♟  ♟
                                6   .  ♝  .  .  .  .  .  .
                                5   .  .  .  .  .  .  .  .
                                4   .  .  .  ♟  .  .  .  .
                                3   .  ♙  ♘  ♙  .  ♗  .  .
                                2   ♙  .  ♙  .  .  ♙  ♙  ♙
                                1   ♖  .  ♗  .  .  .  ♔  .

                                    a  b  c  d  e  f  g  h
                           """
        
        let solution3 = "e8->e1"
        
        
        let puzzel4 =      """

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
        
        let solution4 = "h4->f7"
        
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel1,solution:solution1), "failed for \n \(puzzel1)")
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel2,solution:solution2), "failed for \n \(puzzel2)")
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel3, toMove:.black, solution:solution3), "failed for \n \(puzzel3)")
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel4, toMove:.black, solution:solution4), "failed for \n \(puzzel4)")
    }
    
    func nottestForkPuzzels() {
        
        let puzzel1 =      """

                            8   ♜  ♞  ♝  .  ♚  ♝  .  ♜
                            7   ♟  ♟  ♟  ♟  .  ♟  ♟  ♟
                            6   .  .  .  .  ♛  ♞  .  .
                            5   .  ♘  .  .  ♟  .  .  .
                            4   .  .  .  .  ♙  .  .  .
                            3   .  .  .  .  .  ♘  .  .
                            2   ♙  ♙  ♙  ♙  .  ♙  ♙  ♙
                            1   ♖  .  ♗  ♕  ♔  ♗  .  ♖

                                a  b  c  d  e  f  g  h

                           """
        
        let solution1 = "b5->c7"
        
        let puzzel2 =      """

                                8   ♜  .  ♝  .  ♚  ♝  ♞  ♜
                                7   ♟  .  .  .  ♟  ♟  ♟  ♟
                                6   ♞  ♟  ♟  .  .  .  .  .
                                5   .  .  .  ♟  .  ♛  .  .
                                4   ♕  .  .  .  .  .  .  .
                                3   .  .  ♙  .  ♙  ♘  ♙  .
                                2   ♙  ♙  .  ♙  .  ♙  ♗  ♙
                                1   ♖  ♘  ♗  .  ♔  .  .  ♖

                                    a  b  c  d  e  f  g  h

                           """
        
        let solution2 = "a4->c6"
        
        let puzzel3 =      """

                           8   ♜  .  ♝  ♛  ♚  ♝  ♞  ♜
                           7   ♟  ♟  ♟  .  ♟  .  ♟  ♟
                           6   .  .  .  ♟  .  ♟  .  .
                           5   .  .  .  .  .  .  .  .
                           4   .  ♞  .  .  ♙  .  .  .
                           3   .  .  .  .  .  ♕  ♙  ♘
                           2   ♙  ♙  ♙  ♙  ♗  ♙  .  ♙
                           1   ♖  ♘  ♗  .  ♔  .  .  ♖

                               a  b  c  d  e  f  g  h

                           """
        
        let solution3 = "b4->c2"
        
        
        let puzzel4 =      """

                                8   ♜  .  ♝  ♛  ♚  ♝  .  ♜
                                7   ♟  ♟  ♟  ♟  .  ♟  .  ♟
                                6   .  .  ♞  .  .  ♞  ♟  .
                                5   .  ♗  .  .  ♟  .  .  .
                                4   .  .  .  .  ♙  .  .  .
                                3   .  .  .  ♙  .  ♕  .  .
                                2   ♙  ♙  ♙  .  .  ♙  ♙  ♙
                                1   ♖  ♘  ♗  .  ♔  .  ♘  ♖

                                    a  b  c  d  e  f  g  h

                           """
        
        let solution4 = "c6->d4"
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel1,solution:solution1), "failed for \n \(puzzel1)")
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel2,solution:solution2), "failed for \n \(puzzel2)")
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel3, toMove:.black, solution:solution3), "failed for \n \(puzzel3)")
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel4, toMove:.black, solution:solution4), "failed for \n \(puzzel4)")
    }
    
    func nottestHardPuzzels(){
        
        let puzzel1 = """

                        8   .  .  .  .  .  ♚  .  .
                        7   .  .  .  ♞  .  ♟  .  .
                        6   .  .  .  .  ♟  .  ♜  ♟
                        5   .  .  ♛  .  ♙  ♘  .  .
                        4   .  ♕  .  .  .  .  .  .
                        3   .  .  .  .  .  .  .  .
                        2   .  ♙  .  .  .  ♙  ♙  .
                        1   .  .  .  .  ♖  .  ♔  .
                            
                            a  b  c  d  e  f  g  h

                        """
        
        let solution1 = "e1->c1"
        
        
        let puzzel2 = """

                        8   .  .  .  .  .  .  ♚  .
                        7   .  .  .  .  .  ♜  .  ♟
                        6   ♟  .  .  ♘  .  .  .  .
                        5   ♞  ♟  ♟  ♙  .  .  ♛  .
                        4   .  .  ♙  .  .  .  .  .
                        3   .  ♙  .  ♘  .  .  .  .
                        2   ♙  ♕  .  .  .  .  .  ♙
                        1   .  .  .  .  .  .  .  ♔
                            
                            a  b  c  d  e  f  g  h

                        """
        
        let solution2 = "b2->h8"
        
        
        
        
        
        let puzzel3 = """

                        8   .  .  .  ♛  .  ♜  .  ♚
                        7   .  .  .  .  ♘  .  ♟  ♟
                        6   .  .  .  .  .  .  .  .
                        5   .  .  ♟  .  ♖  .  .  .
                        4   .  .  .  ♞  .  .  .  .
                        3   .  .  .  ♕  .  .  .  .
                        2   .  .  .  .  .  ♙  ♙  ♙
                        1   .  .  .  .  .  .  ♔  .
                            
                            a  b  c  d  e  f  g  h

                        """
        
        let solution3 = "d3->h7"
        
        /*
        //https://www.ichess.net/blog/best-chess-puzzles-for-beginners/
        let puzzel4 = """

                               8   ♜  ♞  ♝  ♛  ♚  ♝  ♞  ♜
                               7   ♟  ♟  ♟  ♟  ♟  ♟  ♟  ♟
                               6   .  .  .  .  .  .  .  .
                               5   .  .  .  .  .  .  .  .
                               4   .  .  .  .  .  .  .  .
                               3   .  .  .  .  .  .  .  .
                               2   ♙  ♙  ♙  ♙  ♙  ♙  ♙  ♙
                               1   ♖  ♘  ♗  ♕  .  ♔  ♘  ♖
                                   
                                   a  b  c  d  e  f  g  h

                               """
               
        let solution4 = ""
        
        
        
        let puzzel5 = """

                        8   ♜  ♞  ♝  ♛  ♚  ♝  ♞  ♜
                        7   ♟  ♟  ♟  ♟  ♟  ♟  ♟  ♟
                        6   .  .  .  .  .  .  .  .
                        5   .  .  .  .  .  .  .  .
                        4   .  .  .  .  .  .  .  .
                        3   .  .  .  .  .  .  .  .
                        2   ♙  ♙  ♙  ♙  ♙  ♙  ♙  ♙
                        1   ♖  ♘  ♗  ♕  ♔  ♗  ♘  ♖
                            
                            a  b  c  d  e  f  g  h

                        """
        
        let solution5 = ""
        
        */
        
        
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel1,solution:solution1), "failed for \n \(puzzel1)")
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel2,solution:solution2), "failed for \n \(puzzel2)")
        
        XCTAssertTrue(checkPuzzel(puzzel:puzzel3,solution:solution3), "failed for \n \(puzzel3)")
    }

    func testPerformanceMiniMax() {
        
        let boardStr =      """

                                8   .  .  .  ♜  .  .  .  ♚
                                7   .  .  .  .  .  .  .  .
                                6   .  .  .  .  ♞  .  .  ♟
                                5   ♛  .  .  ♙  ♘  .  .  .
                                4   .  ♟  ♙  ♗  .  .  .  .
                                3   .  .  .  .  .  .  .  .
                                2   .  .  .  .  .  .  .  .
                                1   .  .  .  ♖  .  ♔  .  .
                                    
                                    a  b  c  d  e  f  g  h

                            """
        //black to move
        let board = Chessboard(string:boardStr)!
        
        self.measure {
            let _ = pickMoveMiniMax(for: board, depth: 3)
            
        }
    }

}

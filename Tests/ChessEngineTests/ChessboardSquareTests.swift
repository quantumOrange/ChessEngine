//
//  ChessboardSquareTests.swift
//  ChessTests
//
//  Created by David Crooks on 11/04/2020.
//  Copyright © 2020 david crooks. All rights reserved.
//

import XCTest
@testable import ChessEngine


class ChessboardSquareTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInt8() throws {
        let sq = ChessboardSquare(rank: ._3, file: .c)
        
       let i = sq.int8Value
        XCTAssert(sq.rank.rawValue == i.rank)
        XCTAssert(sq.file.rawValue == i.file)
        XCTAssert(sq  == i.chessboardSquare)
        
        print(i)
        print( "left \(sq.getNeighbour(.left)!.int8Value)") // - 8
        print( "right \(sq.getNeighbour(.right)!.int8Value)") //+ 8
        print( "top \(sq.getNeighbour(.top)!.int8Value)") //  + 1
        print( "bottom \(sq.getNeighbour(.bottom)!.int8Value)") // -1
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testNieghbors() throws {
        
        
        let emptyboardStr =      """

                                                8   .  .  .  .  .  .  .  .
                                                7   .  .  .  .  .  .  .  .
                                                6   .  .  .  .  .  .  .  .
                                                5   .  .  .  t  .  .  .  .
                                                4   .  .  l  ♖  r  .  .  .
                                                3   .  .  .  b  .  .  .  .
                                                2   .  .  .  .  .  .  .  .
                                                1   .  .  .  .  .  .  .  .
                                                    
                                                    a  b  c  d  e  f  g  h

                                                """
        
        let sq = ChessboardSquare(rank: ._4, file: .d)
        
        let top = ChessboardSquare(rank: ._5, file: .d)
        let bottom = ChessboardSquare(rank: ._3, file: .d)
        let left = ChessboardSquare(rank: ._4, file: .c)
        let right = ChessboardSquare(rank: ._4, file: .e)
        
        let topLeft = ChessboardSquare(rank: ._5, file: .c)
        let bottomLeft = ChessboardSquare(rank: ._3, file: .c)
        let topRight = ChessboardSquare(rank: ._5, file: .e)
        let bottomRight = ChessboardSquare(rank: ._3, file: .e)
        
        //let top = sq.getNeighbour(.top)
       // let bottom = sq.getNeighbour(.top)
        
        
        let i = sq.int8Value
        XCTAssert(sq.getNeighbour(.left) == left)
        XCTAssert(sq.getNeighbour(.right) == right)
        XCTAssert(sq.getNeighbour(.bottom) == bottom)
        XCTAssert(sq.getNeighbour(.top) == top)
       
        XCTAssert(sq.getNeighbour(.topLeft) == topLeft)
        XCTAssert(sq.getNeighbour(.topRight) == topRight)
        XCTAssert(sq.getNeighbour(.bottomLeft) == bottomLeft)
        XCTAssert(sq.getNeighbour(.bottomRight) == bottomRight)
        
        print(i)
        print( "left \(left.int8Value  - sq.int8Value)")        // - 8 // decrease file
        print( "right \(right.int8Value - sq.int8Value)")      // + 8  //  increase file
        print( "top \(top.int8Value - sq.int8Value)")          // + 1  // increase rank
        print( "bottom \(bottom.int8Value - sq.int8Value)")    // - 1  //  decrease rank
        
        print( "topLeft \(topLeft.int8Value  - sq.int8Value)")          // - 7
        print( "topRight \(topRight.int8Value - sq.int8Value)")         // + 9
        print( "bottomLeft \(bottomLeft.int8Value - sq.int8Value)")     // -9
        print( "bottomRight \(bottomRight.int8Value - sq.int8Value)")   // 7
        // This is an example of a functional test case.
        
              //topLeft         // - 7     // increase rank (+1) , decrease file (-8)     //  n =  min ( 7 - rank , file )
              //topRight        // + 9     // increase rank and file                      //  n =  min ( 7 - rank , 1-file )
              //bottomLeft      // - 9     // decrease rank and file                      //  n =  min ( rank , file )
              //bottomRight     // + 7     // decrease rank (-1) , increase file (+8)     //  n =  min (  rank , 1- file )
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testEdges() throws {
       // let i:Int8 = 23
       // i.chessboardSquare
        
        for i in 0..<64 {
let sq = ChessboardSquare(rawValue: Int8(i))!
print(sq)
            /*
            let j = Int8(i)
            let sq = j.chessboardSquare
            let rank = sq.rank
            let file = sq.file
            
            print("case \(file)\(rank) == \")
 */
        }
        //let msq = ChessboardSquare(
        
        let emptyboardStr =      """

                                                8   .  .  .  t  .  .  . tr
                                                7   tl .  .  .  .  .  .  .
                                                6   .  .  .  .  .  .  .  .
                                                5   .  .  .  .  .  .  .  .
                                                4   l  .  .  ♕  .  .  .  r
                                                3   .  .  .  .  .  .  .  .
                                                2   .  .  .  .  .  .  .  .
                                                1   bl .  .  b  .  .  br .
                                                    
                                                    a  b  c  d  e  f  g  h

                                                """
        
        let sq = ChessboardSquare(rank: ._4, file: .d)
        
        let top = ChessboardSquare(rank: ._8, file: .d)
        let bottom = ChessboardSquare(rank: ._1, file: .d)
        let left = ChessboardSquare(rank: ._4, file: .a)
        let right = ChessboardSquare(rank: ._4, file: .h)
        
        let topLeft = ChessboardSquare(rank: ._7, file: .a)
        let bottomLeft = ChessboardSquare(rank: ._1, file: .a)
        let topRight = ChessboardSquare(rank: ._8, file: .h)
        let bottomRight = ChessboardSquare(rank: ._1, file: .g)
        
        //let top = sq.getNeighbour(.top)
        //let bottom = sq.getNeighbour(.top)
        
        
        let rank = sq.int8Value.rank
        let file = sq.int8Value.file
        
        // i = file*8  + rank
        
        let l =   rank  //rank ,  file = 0
        let r =   7*8  + rank // rank ,  file = 7
        let t =   file * 8  + 7  // rank = 7, file
        let b =   file * 8   // rank = 0,  file
        /*
        let tl = file*8  + rank
        let tr = file*8  + rank
        let bl = file*8  + rank
        let br = file*8  + rank
        */
        
        let i = sq.int8Value
        
        
        XCTAssert(l == left.int8Value)
        XCTAssert(r == right.int8Value)
        XCTAssert(b == bottom.int8Value)
        XCTAssert(t == top.int8Value)
       
        
        print(i)
        print( "left \(left.int8Value)")        // - 8
        print( "right \(right.int8Value)")      // + 8
        print( "top \(top.int8Value)")          // + 1
        print( "bottom \(bottom.int8Value)")    // - 1
        
        func printSq(_ sq:String){
            print("\(sq):\(ChessboardSquare(code: sq)!.int8Value) ")
        }
        printSq("f1")
        printSq("g1")
        
        printSq("d1")
        printSq("c1")
        printSq("f8")
        printSq("g8")
        printSq("d8")
        printSq("c8")
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

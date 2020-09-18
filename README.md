# ChessEngine

A simple chess engine. 

## Usage:

To create a chessboard in its start position:
``` swift

   let chessboard = Chessboard.start()
   
```

You can also create a board in any configuration with a string like this:

``` swift
    let chessString =
                    """
                            8   ♜  ♞  ♝  ♛  ♚  .  ♞  ♜
                            7   ♟  ♟  ♟  ♟  .  ♟  .  .
                            6   .  .  .  .  .  .  ♟  ♟
                            5   .  .  .  .  ♟  .  .  .
                            4   .  .  ♗  .  ♙  .  .  .
                            3   .  ♙  ♘  .  .  ♕  .  ♘
                            2   ♙  .  ♙  ♔  .  ♙  ♙  ♙
                            1   .  .  .  ♖  ♖  .  .  .

                                a  b  c  d  e  f  g  h
                    
                    """



    let chessboard = Chessboard(string: chessString) 
```

You can move a piece on the board like this:

``` swift
let mv = Move(from: .e2, to:.e4)

let newBoard = apply(move: mv, to: chessboard)
```

To get the chess engimne to generate a move, call pickMove, optionally passing in a depth value to tell the engine how many moves to look ahead:

``` swift
    let move = pickMove(for:chessboard, depth: 5) 
```




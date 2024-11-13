---
title: Ascii Chess
output:
  html_document:
    includes:
      in_header: header.html
---

<style>
body {
    width: 50em;
    margin: 0 auto;
    font-family: Tahoma, Verdana, Arial, sans-serif;
    padding: 20px; /* Add padding */
    justify-content: space-evenly;
}
.iframe-wrapper {
    padding: 0px;
    width: 100%;
    margin: 0 auto;
}
.iframe-wrapper iframe {
    width: 100%;
    height: 500px;
}
</style>

Ascii chess can help understand PGN (portable game notation) and FEN (Forsyth-Edwards Notation), and can assist in developing the mental imagery for blindfold chess, memory of positions and games, and positional lookahead. This page serves as an introductory manual for the Ascii application displayed below, also accessible at [https://josh-b-merrell.shinyapps.io/my-chess/](https://josh-b-merrell.shinyapps.io/my-chess/)):  

<iframe src="https://josh-b-merrell.shinyapps.io/my-chess/" style="width:50em; height:700px; border:none;"></iframe>

# Basic Usage

## Submit/Undo Moves
Below the Ascii View is a dropdown and an input box for submitting moves. The Undo button undoes the last move. The Submit Move button submits the contents of the input box. The input box can be manually edited or populated from the dropdown box.  

The dropdown box might be helpful in cases where, for example, two black knights are located on b8 and f6 and can move to d7. In this case, the proper notation for moving knight to d7 is Nbd7 or Nfd7 rather than simply Nd7. In such cases, guessing the correct input can be frustrating.  

## Move History

The move history is a form of PGN (portable game notation), though PGN is not as standardized as FEN (see list of other notation examples below). Unlike FEN, PGN capitalizes pieces of both colors to distinguish from files/columns of squares (if no piece is specified, it is a pawn). For the history,  

`e4 e4 Bd3 Nh6`:  

The notation specifies the piece names (or lack thereof for pawns) and their destinations, and leaves the move numbers, colors, origin squares, and other details to be infered as follows:  

```text
┌───────────────────────────┬┬───────────────────────────────────┬┬─────────────────────────┐
│written                    ││              inferred             ││     alternative notation│
├────────┬──────┬───────────┼┼────────┬─────┬──────┬─────────────┼┼─────────┬───────┬───────┤
│notation│piece │destination││fullmove│color│origin│other        ││SAN seq  │SAN ply│Verbose│
├────────┼──────┼───────────┼┼────────┼─────┼──────┼─────────────┼┼─────────┼───────┼───────┤
│e4      │pawn  │e4         ││1       │white│e2    │en passant=e3││1.e4 e5  │1.e4   │Pe2-e4 │
├────────┼──────┼───────────┼┼────────┼─────┼──────┼─────────────┼┼─────────┼───────┼───────┤
│e5      │pawn  │e5         ││1       │black│e7    │en passant=e6││1.e4 e5  │1...e5 │Pe7-e5 │
├────────┼──────┼───────────┼┼────────┼─────┼──────┼─────────────┼┼─────────┼───────┼───────┤
│Bd3     │bishop│d3         ││2       │white│f1    │             ││2.Bd3 Nh6│2.Bd3  │Bf1-d3 │
├────────┼──────┼───────────┼┼────────┼─────┼──────┼─────────────┼┼─────────┼───────┼───────┤
│Nh6     │knight│h6         ││2       │black│h7    │             ││2.Bd3 Nh6│2...Nh6│Ng7-h6 │
└────────┴──────┴───────────┴┴────────┴─────┴──────┴─────────────┴┴─────────┴───────┴───────┘
```

Note how the alternative notations distinguish between white and black:

* SAN seq relies on relative position to the fullmove (Number. White Black)
* SAN ply relies on dots ("." for white, "..." for black)
* Verbose relies on origin move and board state to distinguish white from black.

The correct notation to use depends on the context. The least verbose option is often preferred, as it is more concise and easy to read.

## Ascii board

The Ascii board shows white pieces as capitalized and black pieces as lowercase.  

```text
┌──────┬─────┬─────┐
│Piece │White│Black│
├──────┼─────┼─────┤
│Pawn  │P    │p    │
├──────┼─────┼─────┤
│Knight│N    │n    │
├──────┼─────┼─────┤
│Bishop│B    │b    │
├──────┼─────┼─────┤
│Rook  │R    │r    │
├──────┼─────┼─────┤
│Queen │Q    │q    │
├──────┼─────┼─────┤
│King  │K    │k    │
└──────┴─────┴─────┘
```

## FEN string
FEN stands for Forsyth-Edwards Notation, and [its Wikipedia page](https://en.wikipedia.org/wiki/Forsyth–Edwards_Notation) is highly informative. The FEN consists of 6 fields separated by spaces. The first field is separated into 8 subfields separated by forward-slashes, depicting ranks.  

```text
 1 - Piece Placement                         2  3   4 5 6 
┌───────────────────────────────────────────┬─┬────┬─┬─┬─┐
 rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1
└────────┴────────┴─┴─┴─┴─┴────────┴────────┘
 rank 8   rank 7   6 5 4 3   rank 2   rank 1
```

These fields can be labelled:  

 1. Piece Placement
     - letters for pieces (see table under *Ascii Board*)
     - numbers for empty squares
     - from rank to rank, `left-to-right ~ 8-to-1`
     - within a rank, `left-to-right ~ a-to-h`
 2. Active color (whose turn it is) `w ~ white; b ~ black`
 3. Castling availability
     - `K` for white kingside castle
     - `Q` for white queenside castle
     - `k` for black kingside castle
     - `q` for black queenside castle
     - `-` for no castling availability
 4. En Passant target square (`-` if none)
 5. Halfmove Clock for (fifty-move rule)[https://en.wikipedia.org/wiki/Fifty-move_rule]
 6. Fullmove number - the number of full moves starting at 1 and incrementing after Black's moves.



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

I have been relying on Ascii chess to study. I built the following application to help me (also available at [https://brantmerrell.shinyapps.io/my-chess/](https://brantmerrell.shinyapps.io/my-chess/)):  

<iframe src="https://brantmerrell.shinyapps.io/my-chess/" style="width:50em; height:900px; border:none;"></iframe>

# Reasoning

I want to develop my own mental visuals to describe the game's history, current position, and possible futures. The regular board with colored squares and shaped pieces is distracting to this goal. 

# Basic Usage

## Submit/Undo Moves
Below the Ascii View is a dropdown and an input box for submitting moves. The Undo button undoes the last move. The Submit Move button submits the contents of the input box. The input box can be manually edited or populated from the dropdown box.  

The dropdown box might be helpful in cases where, for example, two black knights are located on b8 and f6 and can move to d7. In this case, the proper notation for moving knight to d7 is Nbd7 or Nfd7 rather than simply Nd7. In such case, guessing the correct input can be frustrating.  

## Reading the Move History

The move history is a form of PGN (portable game notation), though PGN is not as standardized as FEN (see list of other notation examples below). Unlike FEN, PGN capitalizes pieces of both colors to distinguish from files/columns of squares (if no piece is specified, it is a pawn). For the history,  

`e4 e4 Bd3 Nh6`:  

The notation specifies the piece names (or lack thereof for pawns) and their destinations, and leaves the move numbers, colors, origin squares, and other details to be infered as follows:  

```text
┌───────────────────────────┬┬───────────────────────────────────┐
│written                    ││                           inferred│
├────────┬──────┬───────────┼┼────────┬─────┬──────┬─────────────┤
│notation│piece │destination││fullmove│color│origin│other        │
├────────┼──────┼───────────┼┼────────┼─────┼──────┼─────────────┤
│e4      │pawn  │e4         ││1       │white│e2    │en passant=e3│
├────────┼──────┼───────────┼┼────────┼─────┼──────┼─────────────┤
│e5      │pawn  │e5         ││1       │black│e7    │en passant=e6│
├────────┼──────┼───────────┼┼────────┼─────┼──────┼─────────────┤
│Bd3     │bishop│d3         ││2       │white│f1    │             │
├────────┼──────┼───────────┼┼────────┼─────┼──────┼─────────────┤
│Nh6     │knight│h6         ││2       │black│h7    │             │
└────────┴──────┴───────────┴┴────────┴─────┴──────┴─────────────┘
```

Some other notations for displaying this same history are:  

 - `1.e4 e5 2. Bd3 Nh6` - used by chess.com and lichess
 - `1.e4 1...e5 2.Bd3 2...Nh6` - good for discussions that must specify half-moves and color
 - `1.Pe2-e4 Pe7-e5 2.Bf1-d3 Ng7-h6` - I saw this on a phone application once

The correct notation to use is context-dependent. The least verbose option currently fits my purposes for Ascii Chess.  

## Reading the Ascii board

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

## Reading the FEN string
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
     - letters for pieces (see table under *Reading the Ascii Board*)
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


## Manipulating the FEN string

In this application, the FEN string defaults to the standard chess setup:  
```
rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1
```

Left as-is, the **Submit FEN** button can serve as a *reset* for the Ascii board. FEN strings corresponding to tactical puzzles can also be used. The chess.com daily puzzle for December 2, 2023 is `8/8/5K1k/2P4R/3r2B1/pp6/8/8 b - - 0 3` (see [link](https://www.chess.com/daily-chess-puzzle/2023-12-02 )). 



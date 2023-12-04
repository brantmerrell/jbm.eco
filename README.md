
Technical Design  
    - Backend Data Design
        * Unstructured Data
            + HTML of Pre-Structured Games
            + Deep Storage, JSON
        * Structured Data
            + Deep Storage Summary Schema
                * Game Ranges
                * Platforms (FK Game Ranges)
                * User Counts (FK Game Ranges)
                * ELO Stats (FK Game Ranges)
                * Date Ranges (FK Game Ranges)
            + Online Games Schema
                * Platforms (chess.com, lichess.org, etc)
                    + Number of games in deep storage
                * Users (PK ID & FK platform)
                    + Number of games in deep storage
                * Game IDs (FK white, black)
                * Analysis IDs (FK Game)
                * Puzzle IDs (FK platform)
                    + Q: When two platforms have the same puzzle?
                    + A: First grasp statistical probability, then create a design modification
                * User Sample Method (FK User)
                    + Single-User request
                    + API Extraction Flow (L1, L2, L3, etc)
                    + Slow Crawler
                * Game Sample Method (FK Game)
                * Status (FK Platform, User, Game)
                    + Queued
                    + Bucketed
                    + Structured
                    + Archived
                    + Error
        * Web API
            + GET games/
                * query strings:
                    + count=100
                    + elo range=1400:1800
                    + percentile range=92:97
                    + date range=2012-01-01:2016-12-31
                    + platform=chess.com
                    + opening=A1
                    + result=.5-.5
                    + user (white or black)
                    + white (user)
                    + black (user)
                * methodology:
                    + Bad Request if percentile and elo ranges do not overlap
                    + If no users matching, trigger & await User function
                    + identify ranges of random that fit query strings
                    + query on generated IDs
                    + Warning if there are less than the requested count
            + GET game/
                * query strings:
                    + Platform
                    + Type
                    + ID
                * methodology:
                    + query for Game ID
                    + If none, call function
                    + Write function result to DB, return type self
                    + Return result 
            + GET puzzles/
                * query strings:
                    + count=30
                    + difficulty scores=1500:2000
                    + pass rate => .67
                    + percentile range=92:97
                    + date range=2016-01-01:2020-12-31
                    + platform=chess.com
                    + tag=windmill
                * methodology:
                    + Bad Request if percentile and difficulty do not overlap
                    + Query params based on query strings
            + GET puzzle/
                * query strings:
                    + Platform
                    + ID
                * methodology:
                    + query for Game ID
                    + If none, 
                        + call function
                        + Write function result to DB, return type self
                    + Return result 
        * Slow Crawler
            + Randomly selects increments of 3-15 seconds
            + Hits each platform once per increment
            + Constructs patterned sequence on start 
            + Reads database to avoid duplicates
            + Crawls Analysis IDs before Game IDs?
            + Writes to database to reserve workloads
            + Writes to database to store errors
        * Single-Game function
            + Single-platform, single game
            + Skips Bucket and DB, returns to web API
            + web API writes to DB and returns to _
        * Single-User function
            + Called by web API
            + If get_games=True, get all games and load into DB
            + returns User Info to Web API
            + Web API writes to database
            + Single User and Platform
        * Deep Storage Function
            + Queries ID range from Games
            + Sends to Deep Storage
            + Deletes from Online Games Schema
            + Updates Deep Storage Summary Schema
    - Static Site with Embedded Apps
        * R
        * python
        * JavaScript
        * GoLang
        * Ruby

Site Topics:  
    - Table of Contents
    - Introduction
        * GitHub link(s)
        * Maturity Scale
            + Textual ≲📜
            + Static Visual ≲📊
            + Interactive Visual ≲🐁
            + Data Samples ≲🪣
            + Cloud Support ≲🌩
            + Platform Integrations ≲🔀
                * chess.com
                * lichess.org
    - Just Chess
        * Funneling Exponents
            + Focusing on the center
            + Focusing on high-value pieces
            + Focusing on hot squares
                * fulcrum-like squares
                * strategic squares
                * tension squares
            + Funnel-Measuring Dashboard
        * Ranks, Files, and Diagonals
            + Distances rather than squares
            + Linear Equations
            + Designing an Interactive Illustration
        * Pneumonic Pyramid
            + Absolute Positions: 
                * ranks and files
            + Relative Positions: 
                * shapes and deviations
                * symmetries and deviations
            + Absolute Relationships: 
                * distance to edges
                * distance to center ranks/files
                * distance to long diagonals
            + Relative Relationships
                * protection edges
                * threat edges
                * undiscovered edges
            + Pneumonic Sequences
            + Concepts
        * Chunking part 2
            + Initial Position
            + King's House
            + Pawn's Line
        * Ranks and Files
            + Squares are noise
        * Eye of the Bishop
    - Software ~ Chess
        * Fuzzy-matching for data mapping
    - Algorithms ~ Chess
    - Projects ~ Chess
    - AI ~ Chess
        * What AI can and cannot do ~ Funneling Exponents

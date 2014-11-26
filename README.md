# Toy Robot Simulator
[![Build Status](https://travis-ci.org/paulfioravanti/toy_robot.png?branch=master)](https://travis-ci.org/paulfioravanti/toy_robot) [![Code Climate](https://codeclimate.com/github/paulfioravanti/toy_robot.png)](https://codeclimate.com/github/paulfioravanti/toy_robot) [![Test Coverage](https://codeclimate.com/github/paulfioravanti/toy_robot/badges/coverage.svg)](https://codeclimate.com/github/paulfioravanti/toy_robot) [![Dependency Status](https://gemnasium.com/paulfioravanti/toy_robot.png)](https://gemnasium.com/paulfioravanti/toy_robot)

## Description

A simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.  See [Specification](#specification) below for details.

All code is written in Ruby, with some help from [ActiveModel::Validations](http://api.rubyonrails.org/classes/ActiveModel/Validations.html) for model validation checks, and [Thor](https://github.com/wycats/thor) for the command-line interface. 

## Installation

Install gem dependencies with Bundle:

    $ bundle install

## Usage

Input commands manually on command line:

    $ toy_robot

Run commands from a file:

    $ toy_robot -f [filename]

### Extended mode

To enable functionality in the [Extensions](#extensions), pass in the `-e` flag:

Input commands manually on command line in extended mode:

    $ toy_robot -e

Run commands from a file in extended mode:

    $ toy_robot -e -f [filename]

## Testing

Code quality is attempted by using [RSpec](http://rspec.info/) for testing, [SimpleCov](https://github.com/colszowka/simplecov) for code test coverage, [Reek](https://github.com/troessner/reek) to fix code smells, as well as [Code Climate](https://codeclimate.com/) for quality metrics.

Run tests:

    $ rspec spec/

Check test coverage (after running rspec):

    $ open coverage/index.html

Check code smells:

    $ rake reek

## Specification

### Description
- The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement
that would result in the robot falling from the table must be prevented, however further valid movement commands must still
be allowed.

*Create an application that can read in commands of the following form*  
`PLACE X,Y,F`  
`MOVE`  
`LEFT`  
`RIGHT`  
`REPORT`  

- `PLACE` will put the toy robot on the table in position `X,Y` and facing `NORTH`, `SOUTH`, `EAST` or `WEST`.
- The origin (`0,0`) can be considered to be the `SOUTH WEST` most corner.
- The first valid command to the robot is a `PLACE` command, after that, any sequence of commands may be issued, in any order, including another `PLACE` command. The application should discard all commands in the sequence until a valid `PLACE` command has been executed
- `MOVE` will move the toy robot one unit forward in the direction it is currently facing.
- `LEFT` and `RIGHT` will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- `REPORT` will announce the `X`,`Y` and `F` of the robot. This can be in any form, but standard output is sufficient.

<ul>
<li>A robot that is not on the table can choose to ignore the <code>MOVE</code>, <code>LEFT</code>, <code>RIGHT</code> and <code>REPORT</code> commands.</li>
<li>Input can be from a file, or from standard input, as the developer chooses.</li>
<li>Provide test data to exercise the application.</li>
</ul>

### Constraints
The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.
Any move that would cause the robot to fall must be ignored.

Example Input and Output:  
a)  
`PLACE 0,0,NORTH`  
`MOVE`  
`REPORT`  
Output: `0,1,NORTH`  

b)  
`PLACE 0,0,NORTH`  
`LEFT`  
`REPORT`  
Output: `0,0,WEST`  

c)  
`PLACE 1,2,EAST`  
`MOVE`  
`MOVE`  
`LEFT`  
`MOVE`  
`REPORT`  
Output: `3,3,NORTH`

### Deliverables
The Ruby source files, the test data and any test code.
It is not required to provide any graphical output showing the movement of the toy robot.

## Extensions

### Color output

Terminals that are ANSI-color compatible will get the benefit of fun colors in the output.

### Help

The `HELP` command prints out the usage message to the console.

### Multiple Robots

Multiple robots can be placed on the same board, and will move around without bumping into each other.

A `PLACE` command can be made as per the standard app (`PLACE 2,2,NORTH`), and the robot will automatically be given the sequential name of "`R1`", "`R2`" etc depending on the number of robots on the board.  Otherwise, you can name a robot by appending it to the command eg: `PLACE 2,2,NORTH Kryten`.  

If there is only one robot on the board, it can be controlled by commands with or without its name.  However, on a board with multiple robots, a robot's name must be specified in order to determine the target of the command eg: `MOVE Kryten`.

### Spin 180°

The `SPIN [ROBOT_NAME]` command 'spins' a robot 180°, effectively performing two turns at once, to face in the opposite direction.

### Placing Blocks

The `BLOCK [ROBOT_NAME]` command puts a block on the square in front of the robot.  Robots cannot pass through any blocks, either their own, or those placed by other robots.  Any attempts to move through a block, be placed on a block, or place a block on a block are ignored.

### Visual Map of Board

The `MAP [ROBOT_NAME] [BOARD]` command shows a visual map of the board from three perspectives:

- `MAP` by itself shows the full map of the board, including the position and direction of all robots on the board (`Λ > V <`) and all the blocks they have placed (`█`).  For example:

           0   1   2   3   4
        4 [ ] [ ] [ ] [█] [ ]
        3 [ ] [ ] [█] [V] [█]
        2 [ ] [█] [ ] [█] [ ]
        1 [█] [Λ] [█] [ ] [ ]
        0 [ ] [█] [ ] [ ] [ ]
        Robots on the Board:
        Name: Kryten
        Kryten's Position: 1,1,NORTH
        Kryten's Blocks at Positions:
        [0, 1], [1, 0], [1, 2],
        [2, 1]
        -------
        Name: Marvin
        Marvin's Position: 3,3,SOUTH
        Marvin's Blocks at Positions:
        [2, 3], [3, 2], [3, 4],
        [4, 3]
        -------

- `MAP ROBOT_NAME` shows the map from the robot's perspective.  The robot knows only about the position and direction of itself, as well as the locations of all blocks it has placed, but still cannot move to spaces occupied by another robot or its blocks.  For the example above:

        > MAP Kryten

           0   1   2   3   4
        4 [ ] [ ] [ ] [ ] [ ]
        3 [ ] [ ] [ ] [ ] [ ]
        2 [ ] [█] [ ] [ ] [ ]
        1 [█] [Λ] [█] [ ] [ ]
        0 [ ] [█] [ ] [ ] [ ]
        Kryten's Position: 1,1,NORTH
        Kryten's Blocks at Positions:
        [0, 1], [1, 0], [1, 2],
        [2, 1]

        > MAP Marvin

           0   1   2   3   4
        4 [ ] [ ] [ ] [█] [ ]
        3 [ ] [ ] [█] [V] [█]
        2 [ ] [ ] [ ] [█] [ ]
        1 [ ] [ ] [ ] [ ] [ ]
        0 [ ] [ ] [ ] [ ] [ ]
        Marvin's Position: 3,3,SOUTH
        Marvin's Blocks at Positions:
        [2, 3], [3, 2], [3, 4],
        [4, 3]

- `MAP BOARD` shows the map from the board's perspective.  The board knows about the spaces on the board that are occupied by an object (×), without any specifics of the object.  For the example above:

           0   1   2   3   4
        4 [ ] [ ] [ ] [×] [ ]
        3 [ ] [ ] [×] [×] [×]
        2 [ ] [×] [ ] [×] [ ]
        1 [×] [×] [×] [ ] [ ]
        0 [ ] [×] [ ] [ ] [ ]
        Occupied Positions:
        [0, 1], [1, 0], [1, 1],
        [1, 2], [2, 1], [2, 3],
        [3, 2], [3, 3], [3, 4],
        [4, 3]

- - -

## Social

<a href="http://stackoverflow.com/users/567863/paul-fioravanti">
  <img src="http://stackoverflow.com/users/flair/567863.png" width="208" height="58" alt="profile for Paul Fioravanti at Stack Overflow, Q&amp;A for professional and enthusiast programmers" title="profile for Paul Fioravanti at Stack Overflow, Q&amp;A for professional and enthusiast programmers">
</a>

[![endorse](http://api.coderwall.com/pfioravanti/endorsecount.png)](http://coderwall.com/pfioravanti)

#### Copyright

Copyright (c) 2013 Paul Fioravanti

See [MIT LICENSE](./LICENSE.txt)  for details.

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/paulfioravanti/toy_robot/trend.png)](https://bitdeli.com/free "Bitdeli Badge")


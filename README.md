# Toy Robot Simulator

## Description

A simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.  See [Specification](#specification) below for details.

All code is written in pure Ruby, with some help from [ActiveModel::Validations](http://api.rubyonrails.org/classes/ActiveModel/Validations.html) for model validation checks, and [Thor](https://github.com/wycats/thor) for the command-line interface. 

## Installation

Install gem dependencies with Bundle:

    $ bundle install

## Usage

Input commands manually on command line:

    $ bin/toy_robot

Run commands from a file:

    $ bin/toy_robot -f [filename]

### Extended mode

To enable functionality in the [Extensions](#extensions), pass in the `-e` flag:

Input commands manually on command line:

    $ bin/toy_robot -e

Run commands from a file:

    $ bin/toy_robot -e -f [filename]

## Testing

Code quality is attempted by using [RSpec](http://rspec.info/) for testing, [SimpleCov](https://github.com/colszowka/simplecov) for code test coverage, [Reek](https://github.com/troessner/reek) to fix code smells, and [Code Climate](https://codeclimate.com/) for quality metrics.

Run tests:

    $ rspec spec/

Check test coverage (after running rspec):

    $ open coverage/index.html

Check code smells:

    $ rake reek

Check quality metrics:

[![Code Climate](https://codeclimate.com/github/paulfioravanti/toy_robot.png)](https://codeclimate.com/github/paulfioravanti/toy_robot)

## Specification

### Description
- The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement
that would result in the robot falling from the table must be prevented, however further valid movement commands must still
be allowed.


*Create an application that can read in commands of the following form*  
PLACE X,Y,F  
MOVE  
LEFT  
RIGHT  
REPORT  

<ul>
<li>PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.</li>
<li>The origin (0,0) can be considered to be the SOUTH WEST most corner.</li>
<li>The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed</li>
<li>MOVE will move the toy robot one unit forward in the direction it is currently facing.</li>
<li>LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.</li>
<li>REPORT will announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient.</li>
</ul>
<ul>
<li>A robot that is not on the table can choose to ignore the MOVE, LEFT, RIGHT and REPORT commands.</li>
<li>Input can be from a file, or from standard input, as the developer chooses.</li>
<li>Provide test data to exercise the application.</li>
</ul>

### Constraints
The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.
Any move that would cause the robot to fall must be ignored.

Example Input and Output:  
a)  
PLACE 0,0,NORTH  
MOVE  
REPORT  
Output: 0,1,NORTH  

b)  
PLACE 0,0,NORTH  
LEFT  
REPORT  
Output: 0,0,WEST  

c)  
PLACE 1,2,EAST  
MOVE  
MOVE  
LEFT  
MOVE  
REPORT  
Output: 3,3,NORTH

### Deliverables
The Ruby source files, the test data and any test code.
It is not required to provide any graphical output showing the movement of the toy robot.

## Extensions

### Help

The HELP command prints out the usage message to the console.

### Spin 180°

The SPIN command 'spins' the robot 180°, effectively performing two turns at once, to face in the opposite direction.

### Placing Blocks

The BLOCK command puts a block on the square in front of the robot.  The Robot cannot pass through any blocks.  Any attempts to move through a block, be placed on a block, or place a block on a block are ignored.

### Visual Map of Board

The MAP command shows a visual map of the board, showing the position and direction of the robot (Λ > V <), as well as the locations of all blocks (X).  For example:

       0   1   2   3   4
    4 [ ] [ ] [ ] [ ] [ ]
    3 [ ] [X] [ ] [ ] [ ]
    2 [ ] [ ] [Λ] [ ] [ ]
    1 [X] [ ] [ ] [ ] [ ]
    0 [ ] [ ] [ ] [ ] [X]
    Robot Position: 2,2,NORTH
    Blocks at positions:
    [0, 1], [1, 3], [4, 0]

- - -

## Social

<a href="http://stackoverflow.com/users/567863/paul-fioravanti">
  <img src="http://stackoverflow.com/users/flair/567863.png" width="208" height="58" alt="profile for Paul Fioravanti at Stack Overflow, Q&amp;A for professional and enthusiast programmers" title="profile for Paul Fioravanti at Stack Overflow, Q&amp;A for professional and enthusiast programmers">
</a>

[![endorse](http://api.coderwall.com/pfioravanti/endorse.png)](http://coderwall.com/pfioravanti)

#### Copyright

Copyright (c) 2013 Paul Fioravanti

See [MIT LICENSE](./LICENSE.txt)  for details.
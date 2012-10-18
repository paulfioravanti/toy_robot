# Toy Robot Simulator

## Description

A simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.  See [Specification](https://github.com/paulfioravanti/toy_robot#specification) below for details.

All code is written in pure Ruby, with some help from [ActiveModel::Validations](http://api.rubyonrails.org/classes/ActiveModel/Validations.html) for model validation checks, [ActiveModel::Callbacks](http://api.rubyonrails.org/classes/ActiveModel/Callbacks.html) for Rails `before_filter`-like behaviour, and [Thor](https://github.com/wycats/thor) for the command-line interface. 

If you find this repo useful, please help me level-up on [Coderwall](http://coderwall.com/) with an [![endorse](http://api.coderwall.com/pfioravanti/endorse.png)](http://coderwall.com/pfioravanti)

## Installation

Install

    $ bundle install

## Usage

Input commands manually on command line:

    $ bin/toy_robot

Input commands through a file

    $ bin/toy_robot -f [filename]

## Testing

Code quality is attempted by using [RSpec](http://rspec.info/) for testing, [SimpleCov](https://github.com/colszowka/simplecov) for code test coverage, [Reek](https://github.com/troessner/reek) to fix code smells, and [Code Climate](https://codeclimate.com/) for quality metrics.

Run tests:

    $ rspec spec/

Check test coverage (after running rspec):

    $ open coverage/index.html

Check code smells:

    $ rake reek

Check quality metrics:

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/paulfioravanti/toy_robot)

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

- PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
- The origin (0,0) can be considered to be the SOUTH WEST most corner.
- The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed
- MOVE will move the toy robot one unit forward in the direction it is currently facing.
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- REPORT will announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient.

- A robot that is not on the table can choose the ignore the MOVE, LEFT, RIGHT and REPORT commands.  
- Input can be from a file, or from standard input, as the developer chooses.  
- Provide test data to exercise the application.  

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

## Copyright

Copyright (c) 2012 Paul Fioravanti

See [LICENSE.txt](https://github.com/paulfioravanti/toy_robot/blob/master/LICENSE.txt)  for details.
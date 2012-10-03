# Toy Robot Simulator [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/paulfioravanti/toy_robot)

## Description

A simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.

All code is written in pure Ruby, with some help from [ActiveModel::Validations](http://api.rubyonrails.org/classes/ActiveModel/Validations.html) for model validation checks and [Thor](https://github.com/wycats/thor) for the command-line interface, and is tested using RSpec.

If you find this repo useful, please help me level-up on [Coderwall](http://coderwall.com/) with an [![endorse](http://api.coderwall.com/pfioravanti/endorse.png)](http://coderwall.com/pfioravanti)

## Installation

Install

    $ bundle install

## Usage

Input commands manually on command line:

    $ bin/toy_robot

Input commands through a file

    $ bin/toy_robot -f [filename]

Run tests:

    $ rspec spec/

Check test coverage (after running rspec):

    $ open coverage/index.html

## Issues

- Couldn't figure out how to write tests simulating manual command input (using STDIN), and started a question on StackOverflow about it [here](http://stackoverflow.com/q/12673485/567863).  So, test coverage stays at 99.43% for now.

## Copyright

Copyright (c) 2012 Paul Fioravanti

See [LICENSE.txt](https://github.com/paulfioravanti/toy_robot/blob/master/LICENSE.txt)  for details.
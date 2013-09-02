require 'spec_helper'
# require 'toy_robot'

describe Board do

  let(:board) { Board.new }

  subject { board }

  it_should_behave_like "a board"

  # #within_boundaries? tested in Robot#place in robot_spec.rb
end
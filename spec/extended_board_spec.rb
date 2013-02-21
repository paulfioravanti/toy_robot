require 'spec_helper'
require 'toy_robot'

describe ExtendedBoard do

  let(:board) { ExtendedBoard.new }

  subject { board }

  it_should_behave_like "a board"

  specify "model attributes" do
    should respond_to(:occupied_spaces)
  end

  specify "instance methods" do
    should respond_to(:occupy).with(1).argument
    should respond_to(:release).with(1).argument
    should respond_to(:space_empty?).with(1).argument
  end

  describe "initial state" do
    its(:occupied_spaces) { should be_empty }
  end

  # #within_boundaries? tested in Robot#place in robot_spec.rb
end
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
    should respond_to(:change_position).with(2).arguments
    should respond_to(:space_empty?).with(1).argument
  end

  describe "initial state" do
    its(:occupied_spaces) { should be_empty }
  end

  describe "#occupy" do
    let(:position) { Position.new(1, 1) }
    before { board.occupy(position) }
    its(:occupied_spaces) { should include(position) }
  end

  describe "#change_position" do
    let(:position) { Position.new(1, 1) }
    let(:new_position) { Position.new(2, 2) }

    before do
      board.occupy(position)
      board.change_position(position, new_position)
    end

    its(:occupied_spaces) do
      should_not include(position)
      should include(new_position)
    end
  end

  describe "#space_empty?" do
    let(:position) { Position.new(1, 1) }

    before { board.occupy(position) }

    context "when space is not empty" do
      subject { board.space_empty?(position) }
      it { should be_false }
    end

    context "when space is empty" do
      let(:empty_position) { Position.new(2, 1) }
      subject { board.space_empty?(empty_position) }
      it { should be_true }
    end
  end

  # #within_boundaries? tested in Robot#place in robot_spec.rb
end
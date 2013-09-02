require 'spec_helper'
# require 'toy_robot'

describe ExtendedBoard do

  let(:board) { ExtendedBoard.new }

  subject { board }

  it_should_behave_like "a board"

  specify "model attributes" do
    should respond_to(:occupied_positions)
  end

  specify "instance methods" do
    should respond_to(:occupy).with(1).argument
    should respond_to(:change_position).with(2).arguments
    should respond_to(:space_empty?).with(1).argument
  end

  describe "initial state" do
    its(:occupied_positions) { should be_empty }
  end

  describe "#occupy" do
    let(:position) { Position.new(1, 1) }
    before { board.occupy(position) }
    its(:occupied_positions) { should include(position) }
  end

  describe "#change_position" do
    let(:position) { Position.new(1, 1) }
    let(:new_position) { Position.new(2, 2) }

    before do
      board.occupy(position)
      board.change_position(position, new_position)
    end

    its(:occupied_positions) do
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

  describe "#map" do
    let(:map) { board.map }

    subject { map.gsub(ansi_colors, '') }

    context "before a #place" do
      let(:expected_map) { false }
      before { board.stub_chain(:map, :gsub) { false } }
      it { should == expected_map }
    end

    context "after a #place" do
      let(:robot) { ExtendedRobot.new(board, "R1") }
      let(:expected_map) { robot_2_2_north_with_block_board_map }

      before do
        robot.place(2, 2, "NORTH")
        robot.block
      end

      it { should == expected_map }
    end
  end

  # #within_boundaries? tested in Robot#place in robot_spec.rb
end
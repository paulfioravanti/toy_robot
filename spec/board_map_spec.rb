require 'spec_helper'
require 'toy_robot'

describe BoardMap do

  let(:board) { ExtendedBoard.new }
  let(:robot) { ExtendedRobot.new(board, "R1") }
  let(:map)   { BoardMap.new(board) }

  before { robot.place(2, 2, "NORTH") }

  subject { map }

  it_should_behave_like "a map"

  specify "model attributes" do
    should respond_to(:board, :object_coordinates)
  end

  describe "validations" do
    context "for board" do
      context "when it is nil" do
        before { map.instance_variable_set(:@board, nil) }
        it { should_not be_valid }
      end
    end
  end

  describe "map output" do
    context "with only a robot" do
      let(:expected_map) { robot_any_direction_board_map }

      context "facing NORTH" do
        its(:output) { should == expected_map }
      end

      context "facing EAST" do
        before { robot.place(2, 2, "EAST") }
        its(:output) { should == expected_map }
      end

      context "facing SOUTH" do
        before { robot.place(2, 2, "SOUTH") }
        its(:output) { should == expected_map }
      end

      context "facing WEST" do
        before { robot.place(2, 2, "WEST") }
        its(:output) { should == expected_map }
      end
    end

    context "with a robot and blocks" do
      let(:expected_map) { robot_and_blocks_board_map }

      before do
        4.times do
          robot.block
          robot.right
        end
        robot.place(0, 4, "NORTH")
        4.times do
          robot.block
          robot.left
        end
        robot.place(0, 0, "EAST")
        4.times do
          robot.block
          robot.right
        end
        robot.place(4, 4, "SOUTH")
        4.times do
          robot.block
          robot.right
        end
        robot.place(4, 0, "WEST")
        4.times do
          robot.block
          robot.left
        end
      end

      its(:output) { should == expected_map }
    end
  end
end
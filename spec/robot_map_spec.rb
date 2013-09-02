require 'spec_helper'
# require 'toy_robot'

describe RobotMap do

  let(:board) { ExtendedBoard.new }
  let(:robot) { ExtendedRobot.new(board, "R1") }
  let(:map)   { RobotMap.new(robot) }

  before { robot.place(2, 2, "NORTH") }

  subject { map }

  it_should_behave_like "a map"

  specify "model attributes" do
    should respond_to(:robot, :block_coordinates)
  end

  describe "validations" do
    context "for robot" do
      context "when it is nil" do
        before { map.instance_variable_set(:@robot, nil) }
        it { should_not be_valid }
      end
    end
  end

  describe "map output" do
    subject { map.output.gsub(ansi_colors, '') }

    context "with only a robot" do

      context "facing NORTH" do
        let(:expected_map) { robot_north_map }
        it { should == expected_map }
      end

      context "facing EAST" do
        let(:expected_map) { robot_east_map }
        before { robot.place(2, 2, "EAST") }
        it { should == expected_map }
      end

      context "facing SOUTH" do
        let(:expected_map) { robot_south_map }
        before { robot.place(2, 2, "SOUTH") }
        it { should == expected_map }
      end

      context "facing WEST" do
        let(:expected_map) { robot_west_map }
        before { robot.place(2, 2, "WEST") }
        it { should == expected_map }
      end
    end

    context "with a robot and blocks" do
      let(:expected_map) { robot_and_blocks_map }

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

      it { should == expected_map }
    end
  end
end
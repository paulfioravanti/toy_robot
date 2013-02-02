require 'spec_helper'
require 'toy_robot'

describe Map do

  let(:robot) { Robot.new }
  let(:map) { Map.new(robot) }

  before do
    robot.place(2, 2, "NORTH")
  end

  subject { map }

  specify "model attributes" do
    should respond_to(:x_range, :y_range)
    should respond_to(:robot_coordinates, :robot_direction)
    should respond_to(:block_coordinates, :output)
  end

  describe "initial state" do
    it { should be_valid }
  end

  describe "validations" do
    context "for x_range" do
      context "when it is nil" do
        before { map.instance_variable_set(:@x_range, nil) }
        it { should_not be_valid }
      end
    end

    context "for y_range" do
      context "when it is nil" do
        before { map.instance_variable_set(:@y_range, nil) }
        it { should_not be_valid }
      end
    end

    context "for robot_coordinates" do
      context "when it is nil" do
        before { map.instance_variable_set(:@robot_coordinates, nil) }
        it { should_not be_valid }
      end
    end

    context "for robot_direction" do
      context "when it is nil" do
        before { map.instance_variable_set(:@robot_direction, nil) }
        it { should_not be_valid }
      end
    end
  end

  describe "map output" do
    # Map examples in utilities.rb
    context "with only a robot" do
      context "facing NORTH" do
        let(:expected_map) { robot_north_map }
        its(:output) { should == expected_map }
      end

      context "facing EAST" do
        let(:expected_map) { robot_east_map }
        before { robot.place(2, 2, "EAST") }
        its(:output) { should == expected_map }
      end

      context "facing SOUTH" do
        let(:expected_map) { robot_south_map }
        before { robot.place(2, 2, "SOUTH") }
        its(:output) { should == expected_map }
      end

      context "facing WEST" do
        let(:expected_map) { robot_west_map }
        before { robot.place(2, 2, "WEST") }
        its(:output) { should == expected_map }
      end
    end

    context "with a robot and blocks" do
      let(:expected_map) { robot_and_blocks_map }

      before do
        4.times do
          robot.place_block
          robot.right
        end
        robot.place(0, 4, "NORTH")
        4.times do
          robot.place_block
          robot.left
        end
        robot.place(0, 0, "EAST")
        4.times do
          robot.place_block
          robot.right
        end
        robot.place(4, 4, "SOUTH")
        4.times do
          robot.place_block
          robot.right
        end
        robot.place(4, 0, "WEST")
        4.times do
          robot.place_block
          robot.left
        end
      end

      its(:output) { should == expected_map }
    end
  end
end
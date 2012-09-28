require 'spec_helper'
require 'toy_robot'

describe Robot do

  let(:robot) { Robot.new }

  subject { robot }

  describe "model attributes" do
    it { should respond_to(:current_x) }
    it { should respond_to(:current_y) }
    it { should respond_to(:current_direction) }
  end

  describe "initial state" do
    it { should be_valid }
  end

  describe "instance methods" do
    it { should respond_to(:left).with(0).arguments }
    it { should respond_to(:right).with(0).arguments }
    it { should respond_to(:move).with(0).arguments }
    it { should respond_to(:report).with(0).arguments }
  end

  describe "validations" do

    context "for current direction" do
      context "when it is invalid" do
        before { robot.current_direction = "INVALID" }
        it { should_not be_valid }
      end

      context "when it is nil" do
        before { robot.current_direction = nil }
        it { should be_valid }
      end
    end

    context "for coordinates" do
      context "when they are not integers" do
        coordinate_values.each do |coordinate|
          before { robot.instance_variable_set(coordinate, "invalid") }
          it { should_not be_valid }
        end
      end

      context "when they are nil" do
        coordinate_values.each do |coordinate|
          before { robot.instance_variable_set(coordinate, nil) }
          it { should be_valid }
        end
      end
    end

  end

  shared_examples_for "all board placements" do
    its(:current_x) { should == expected_x }
    its(:current_y) { should == expected_y }
    its(:current_direction) { should == expected_direction }
  end

  describe "being placed on a board" do
    let(:board) { Board.new(0, 4, 4, 0) }

    context "in a valid position and direction" do
      let(:expected_x) { 2 }
      let(:expected_y) { 2 }
      let(:expected_direction) { "NORTH" }

      before do
        board.place(robot, 2, 2, "NORTH")
      end

      it_should_behave_like "all board placements"
    end

    context "in an invalid position" do
      let(:expected_x) { nil }
      let(:expected_y) { nil }
      let(:expected_direction) { nil }

      context "on the x axis" do
        context "in the east" do
          before do
            board.place(robot, 5, 2, "NORTH")
          end

          it_should_behave_like "all board placements"
        end

        context "in the west" do
          before do
            board.place(robot, -1, 2, "NORTH")
          end

          it_should_behave_like "all board placements"
        end
      end

      context "on the y axis" do
        context "in the north" do
          before do
            board.place(robot, 2, 5, "NORTH")
          end

          it_should_behave_like "all board placements"
        end

        context "in the south" do
          before do
            board.place(robot, 2, -1, "NORTH")
          end

          it_should_behave_like "all board placements"
        end
      end
    end

  end

  # describe "moving" do
  #   let(:board) { Board.new(0, 4, 0, 4) }
  #   context "when there is a space in front of it" do
  #     context "to the north" do
  #       before do
  #         board.place(robot, 2, 2, "NORTH")
  #       end
  #     end
  #     context "to the east" do

  #     end
  #     context "to the south" do

  #     end
  #     context "to the west" do

  #     end
  #   end
  #   context "when there is not a space in front of it" do
  #     context "to the north" do

  #     end
  #     context "to the east" do

  #     end
  #     context "to the south" do

  #     end
  #     context "to the west" do

  #     end
  #   end
  # end

  describe "reporting" do
    before do
      robot.current_x = 0
      robot.current_y = 0
      robot.current_direction = "NORTH"
    end

    its(:report) do
      should == { current_x: 0, current_y: 0, current_direction: "NORTH" }
    end
  end

  describe "turning" do
    valid_directions.each_with_index do |direction, index|

      context "left" do
        let(:left_turns) { valid_directions.rotate(-1) }
        before do
          robot.current_direction = direction
          robot.left
        end
        its(:current_direction) { should == left_turns[index] }
      end

      context "right" do
        let(:right_turns) { valid_directions.rotate }
        before do
          robot.current_direction = direction
          robot.right
        end
        its(:current_direction) { should == right_turns[index] }
      end

    end
  end

end
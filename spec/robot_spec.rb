require 'spec_helper'
require 'toy_robot'

describe Robot do

  let(:board) do
    Board.new(left_boundary: 0, right_boundary: 4,
              top_boundary: 4, bottom_boundary: 0)
  end
  let(:robot) { Robot.new(board: board) }

  subject { robot }

  describe "model attributes" do
    it { should respond_to(:board) }
    it { should respond_to(:x_position) }
    it { should respond_to(:y_position) }
    it { should respond_to(:cardinal_direction) }
  end

  describe "initial state" do
    it { should be_valid }
    its(:board) { should == board }
  end

  describe "instance methods" do
    it { should respond_to(:place).with(3).arguments }
    it { should respond_to(:move).with(0).arguments }
    it { should respond_to(:left).with(0).arguments }
    it { should respond_to(:right).with(0).arguments }
    it { should respond_to(:report).with(0).arguments }
  end

  describe "validations" do
    context "for board" do
      before { robot.instance_variable_set(:@board, nil) }
      it { should_not be_valid }
    end

    context "for current direction" do
      context "when it is invalid" do
        before { robot.cardinal_direction = "INVALID" }
        it { should_not be_valid }
      end

      context "when it is nil" do
        before { robot.cardinal_direction = nil }
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

  shared_examples_for "all robot attributes at time of placement" do
    its(:x_position) { should == expected_x }
    its(:y_position) { should == expected_y }
    its(:cardinal_direction) { should == expected_cardinal }
  end

  describe "being placed on a board" do
    let(:expected_x) { 2 }
    let(:expected_y) { 2 }
    let(:expected_cardinal) { "NORTH" }

    before do
      robot.place(2, 2, "NORTH")
    end

    context "in a valid position and direction" do
      it_should_behave_like "all robot attributes at time of placement"

      context "and then re-placed validly" do
        let(:expected_x) { 3 }
        let(:expected_y) { 3 }
        let(:expected_cardinal) { "SOUTH" }

        before do
          robot.place(3, 3, "SOUTH")
        end

        it_should_behave_like "all robot attributes at time of placement"
      end
    end

    context "in an invalid position" do
      # Expect no change from original placement of 2, 2, "NORTH"
      context "too far on the x axis" do
        context "to the east" do
          before do
            robot.place(5, 2, "NORTH")
          end

          it_should_behave_like "all robot attributes at time of placement"
        end

        context "to the west" do
          before do
            robot.place(-1, 2, "NORTH")
          end

          it_should_behave_like "all robot attributes at time of placement"
        end
      end

      context "too far on the y axis" do
        context "to the north" do
          before do
            robot.place(2, 5, "NORTH")
          end

          it_should_behave_like "all robot attributes at time of placement"
        end

        context "to the south" do
          before do
            robot.place(2, -1, "NORTH")
          end

          it_should_behave_like "all robot attributes at time of placement"
        end
      end
    end
  end

  describe "moving" do
    context "when there is a space ahead" do
      before { robot.place(2, 2, "NORTH") }

      context "to the north" do
        let(:expected_x) { 2 }
        let(:expected_y) { 3 }
        let(:expected_cardinal) { "NORTH" }

        before { robot.move }

        it_should_behave_like "all robot attributes at time of placement"
      end

      context "to the east" do
        let(:expected_x) { 3 }
        let(:expected_y) { 2 }
        let(:expected_cardinal) { "EAST" }

        before do
          robot.right
          robot.move
        end

        it_should_behave_like "all robot attributes at time of placement"
      end

      context "to the south" do
        let(:expected_x) { 2 }
        let(:expected_y) { 1 }
        let(:expected_cardinal) { "SOUTH" }

        before do
          2.times { robot.right }
          robot.move
        end

        it_should_behave_like "all robot attributes at time of placement"
      end

      context "to the west" do
        let(:expected_x) { 1 }
        let(:expected_y) { 2 }
        let(:expected_cardinal) { "WEST" }

        before do
          robot.left
          robot.move
        end

        it_should_behave_like "all robot attributes at time of placement"
      end
    end

    context "when there is not a space ahead" do
      context "to the north" do
        let(:expected_x) { 2 }
        let(:expected_y) { 4 }
        let(:expected_cardinal) { "NORTH" }

        before do
          robot.place(2, 4, "NORTH")
          robot.move
        end

        it_should_behave_like "all robot attributes at time of placement"
      end

      context "to the east" do
        let(:expected_x) { 4 }
        let(:expected_y) { 2 }
        let(:expected_cardinal) { "EAST" }

        before do
          robot.place(4, 2, "EAST")
          robot.move
        end

        it_should_behave_like "all robot attributes at time of placement"
      end

      context "to the south" do
        let(:expected_x) { 2 }
        let(:expected_y) { 0 }
        let(:expected_cardinal) { "SOUTH" }

        before do
          robot.place(2, 0, "SOUTH")
          robot.move
        end

        it_should_behave_like "all robot attributes at time of placement"
      end

      context "to the west" do
        let(:expected_x) { 0 }
        let(:expected_y) { 2 }
        let(:expected_cardinal) { "WEST" }

        before do
          robot.place(0, 2, "WEST")
          robot.move
        end

        it_should_behave_like "all robot attributes at time of placement"
      end
    end

    context "without having been placed" do
      let(:expected_x) { nil }
      let(:expected_y) { nil }
      let(:expected_cardinal) { nil }

      before { robot.move }

      it_should_behave_like "all robot attributes at time of placement"
    end
  end

  describe "turning" do
    context "after being placed" do
      before { robot.place(2, 2, "NORTH") }

      valid_cardinal_directions.each_with_index do |direction, index|
        context "left" do
          let(:left_turns) { valid_cardinal_directions.rotate(-1) }

          before do
            robot.cardinal_direction = direction
            robot.left
          end

          its(:cardinal_direction) { should == left_turns[index] }
        end

        context "right" do
          let(:right_turns) { valid_cardinal_directions.rotate }

          before do
            robot.cardinal_direction = direction
            robot.right
          end

          its(:cardinal_direction) { should == right_turns[index] }
        end
      end
    end

    context "without having been placed" do
      let(:expected_x) { nil }
      let(:expected_y) { nil }
      let(:expected_cardinal) { nil }

      before { robot.left }

      it_should_behave_like "all robot attributes at time of placement"
    end
  end

  describe "reporting" do
    context "after being placed" do
      let(:expected_report) do
        {
          x_position: 2,
          y_position: 2,
          cardinal_direction: "NORTH"
        }
      end

      before do
        robot.place(2, 2, "NORTH")
      end

      its(:report) do
        should == expected_report
      end
    end

    context "without having been placed" do
      let(:expected_report) { nil }

      before { robot.report }

      its(:report) do
        should == expected_report
      end
    end
  end
end
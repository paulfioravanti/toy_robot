require 'spec_helper'
require 'toy_robot'

describe Robot do

  let(:robot) { Robot.new }

  subject { robot }

  specify "model attributes" do
    should respond_to(:board)
    should respond_to(:x_position)
    should respond_to(:y_position)
    should respond_to(:cardinal_direction)
    should respond_to(:placed)
  end

  specify "instance methods" do
    should respond_to(:place).with(3).arguments
    should respond_to(:move).with(0).arguments
    should respond_to(:left).with(0).arguments
    should respond_to(:right).with(0).arguments
    should respond_to(:report).with(0).arguments
  end

  describe "initial state" do
    it { should be_valid }
    its(:board) { should_not be_nil }
    its(:placed) { should be_false }

    context "of its board" do
      subject { robot.board }

      its(:left_boundary) { should == 0 }
      its(:right_boundary) { should == 4 }
      its(:top_boundary) { should == 4 }
      its(:bottom_boundary) { should == 0 }
    end

  end

  describe "validations" do
    context "for board" do
      before { robot.instance_variable_set(:@board, nil) }
      it { should_not be_valid }
    end

    context "for cardinal_direction" do
      context "when it is invalid" do
        before { robot.cardinal_direction = "INVALID" }
        it { should_not be_valid }
      end

      context "when it is nil" do
        before { robot.cardinal_direction = nil }
        it { should be_valid }
      end
    end

    context "for x_position, y_position" do
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

    context "for placed" do
      context "when it is invalid" do
        before { robot.placed = "INVALID" }
        it { should_not be_valid }
      end
    end
  end

  shared_examples_for "a robot at time of placement" do
    its(:x_position) { should == expected_x }
    its(:y_position) { should == expected_y }
    its(:cardinal_direction) { should == expected_cardinal }
  end

  describe "#place" do
    let(:expected_x) { 2 }
    let(:expected_y) { 2 }
    let(:expected_cardinal) { "NORTH" }

    before do
      robot.place(2, 2, "NORTH")
    end

    context "with a valid position and direction" do
      it_should_behave_like "a robot at time of placement"

      context "and then #place again validly" do
        let(:expected_x) { 3 }
        let(:expected_y) { 3 }
        let(:expected_cardinal) { "SOUTH" }

        before do
          robot.place(3, 3, "SOUTH")
        end

        it_should_behave_like "a robot at time of placement"
      end
    end

    context "with an invalid position" do
      # Expect no change from original placement of 2, 2, "NORTH"
      context "too far on the x axis" do
        context "to the east" do
          before do
            robot.place(5, 2, "NORTH")
          end

          it_should_behave_like "a robot at time of placement"
        end

        context "to the west" do
          before do
            robot.place(-1, 2, "NORTH")
          end

          it_should_behave_like "a robot at time of placement"
        end
      end

      context "too far on the y axis" do
        context "to the north" do
          before do
            robot.place(2, 5, "NORTH")
          end

          it_should_behave_like "a robot at time of placement"
        end

        context "to the south" do
          before do
            robot.place(2, -1, "NORTH")
          end

          it_should_behave_like "a robot at time of placement"
        end
      end
    end
  end

  describe "#move" do
    context "when there is a space ahead" do
      before { robot.place(2, 2, "NORTH") }

      context "to the north" do
        let(:expected_x) { 2 }
        let(:expected_y) { 3 }
        let(:expected_cardinal) { "NORTH" }

        before { robot.move }

        it_should_behave_like "a robot at time of placement"
      end

      context "to the east" do
        let(:expected_x) { 3 }
        let(:expected_y) { 2 }
        let(:expected_cardinal) { "EAST" }

        before do
          robot.right
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end

      context "to the south" do
        let(:expected_x) { 2 }
        let(:expected_y) { 1 }
        let(:expected_cardinal) { "SOUTH" }

        before do
          2.times { robot.right }
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end

      context "to the west" do
        let(:expected_x) { 1 }
        let(:expected_y) { 2 }
        let(:expected_cardinal) { "WEST" }

        before do
          robot.left
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
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

        it_should_behave_like "a robot at time of placement"
      end

      context "to the east" do
        let(:expected_x) { 4 }
        let(:expected_y) { 2 }
        let(:expected_cardinal) { "EAST" }

        before do
          robot.place(4, 2, "EAST")
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end

      context "to the south" do
        let(:expected_x) { 2 }
        let(:expected_y) { 0 }
        let(:expected_cardinal) { "SOUTH" }

        before do
          robot.place(2, 0, "SOUTH")
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end

      context "to the west" do
        let(:expected_x) { 0 }
        let(:expected_y) { 2 }
        let(:expected_cardinal) { "WEST" }

        before do
          robot.place(0, 2, "WEST")
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end
    end

    context "without having been #placed?" do
      let(:expected_x) { nil }
      let(:expected_y) { nil }
      let(:expected_cardinal) { nil }

      before { robot.move }

      it_should_behave_like "a robot at time of placement"
    end
  end

  describe "turning" do
    context "after a #place" do

      subject { robot.cardinal_direction }

      before { robot.place(2, 2, "NORTH") }

      valid_cardinals.each_with_index do |direction, index|
        context "then #left" do
          let(:left_turns) { valid_cardinals.rotate(-1) }

          before do
            robot.cardinal_direction = direction
            robot.left
          end

          it { should == left_turns[index] }
        end

        context "then #right" do
          let(:right_turns) { valid_cardinals.rotate }

          before do
            robot.cardinal_direction = direction
            robot.right
          end

          it { should == right_turns[index] }
        end
      end
    end

    context "before a #place" do
      let(:expected_x) { nil }
      let(:expected_y) { nil }
      let(:expected_cardinal) { nil }

      before { robot.left }

      it_should_behave_like "a robot at time of placement"
    end
  end

  describe "#report" do

    subject { robot.report }

    context "before a #place" do
      let(:expected_report) { false }

      it { should == expected_report }
    end

    context "after a #place" do
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

      it { should == expected_report }
    end
  end
end
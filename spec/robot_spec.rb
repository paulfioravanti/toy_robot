require 'spec_helper'
require 'toy_robot'

describe Robot do

  let(:robot) { Robot.new }

  subject { robot }

  specify "model attributes" do
    should respond_to(:board)
    should respond_to(:position)
    should respond_to(:cardinal_direction)
    # should respond_to(:placed)
    should respond_to(:blocks)
  end

  specify "instance methods" do
    should respond_to(:place).with(3).arguments
    should respond_to(:place_block).with(0).arguments
    should respond_to(:move).with(0).arguments
    should respond_to(:left).with(0).arguments
    should respond_to(:right).with(0).arguments
    should respond_to(:report).with(0).arguments
  end

  describe "initial state" do
    it { should be_valid }
    its(:board)  { should_not be_nil }
    its(:blocks) do
      should_not be_nil
      should be_empty
    end

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
  end

  shared_examples_for "an object at time of placement" do
    its(:position) { should == expected_position }
  end

  shared_examples_for "a robot at time of placement" do
    it_should_behave_like "an object at time of placement"
    its(:cardinal_direction) { should == expected_cardinal }
  end

  describe "#place" do
    let(:expected_position) do
      double("position", x_coordinate: 2, y_coordinate: 2)
    end
    let(:expected_cardinal) { "NORTH" }

    before do
      robot.place(2, 2, "NORTH")
    end

    context "with a valid position and direction" do
      it_should_behave_like "a robot at time of placement"

      context "and then #place again validly" do
        let(:expected_position) do
          double("position", x_coordinate: 3, y_coordinate: 3)
        end
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

  describe "#place_block" do
    context "in a valid position" do

      before do
        robot.place(2, 2, "NORTH")
        robot.place_block
      end

      its(:blocks) { should have(1).items }

      context "in front of robot" do
        context "facing NORTH" do
          let(:expected_position) do
            double("position", x_coordinate: 2, y_coordinate: 3)
          end

          subject { robot.blocks.last }

          it_should_behave_like "an object at time of placement"
        end

        context "facing EAST" do
          let(:expected_position) do
            double("position", x_coordinate: 3, y_coordinate: 2)
          end

          before do
            robot.right
            robot.place_block
          end

          subject { robot.blocks.last }

          it_should_behave_like "an object at time of placement"
        end

        context "facing SOUTH" do
          let(:expected_position) do
            double("position", x_coordinate: 2, y_coordinate: 1)
          end

          before do
            2.times { robot.right }
            robot.place_block
          end

          subject { robot.blocks.last }

          it_should_behave_like "an object at time of placement"
        end

        context "facing WEST" do
          let(:expected_position) do
            double("position", x_coordinate: 1, y_coordinate: 2)
          end

          before do
            robot.left
            robot.place_block
          end

          subject { robot.blocks.last }

          it_should_behave_like "an object at time of placement"
        end
      end
    end

    context "in an invalid position" do
      context "over board boundaries" do

        before do
          robot.place(2, 4, "NORTH")
          robot.place_block
        end

        its(:blocks) { should have(0).items }
      end

      context "where a block already exists" do

        before do
          robot.place(2, 2, "NORTH")
          2.times { robot.place_block }
        end

        its(:blocks) { should have(1).items }
      end
    end

    context "without having been placed" do

      before { robot.place_block }

      its(:blocks) { should have(0).items }
    end
  end

  describe "#move" do
    context "when there is a space ahead" do

      before { robot.place(2, 2, "NORTH") }

      context "to the NORTH" do
        let(:expected_position) do
          double("position", x_coordinate: 2, y_coordinate: 3)
        end
        let(:expected_cardinal) { "NORTH" }

        before { robot.move }

        it_should_behave_like "a robot at time of placement"
      end

      context "to the EAST" do
        let(:expected_position) do
          double("position", x_coordinate: 3, y_coordinate: 2)
        end
        let(:expected_cardinal) { "EAST" }

        before do
          robot.right
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end

      context "to the SOUTH" do
        let(:expected_position) do
          double("position", x_coordinate: 2, y_coordinate: 1)
        end
        let(:expected_cardinal) { "SOUTH" }

        before do
          2.times { robot.right }
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end

      context "to the WEST" do
        let(:expected_position) do
          double("position", x_coordinate: 1, y_coordinate: 2)
        end
        let(:expected_cardinal) { "WEST" }

        before do
          robot.left
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end
    end

    context "when there is not a space ahead" do
      context "to the NORTH" do
        let(:expected_position) do
          double("position", x_coordinate: 2, y_coordinate: 4)
        end
        let(:expected_cardinal) { "NORTH" }

        before do
          robot.place(2, 4, "NORTH")
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end

      context "to the EAST" do
        let(:expected_position) do
          double("position", x_coordinate: 4, y_coordinate: 2)
        end
        let(:expected_cardinal) { "EAST" }

        before do
          robot.place(4, 2, "EAST")
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end

      context "to the SOUTH" do
        let(:expected_position) do
          double("position", x_coordinate: 2, y_coordinate: 0)
        end
        let(:expected_cardinal) { "SOUTH" }

        before do
          robot.place(2, 0, "SOUTH")
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end

      context "to the WEST" do
        let(:expected_position) do
          double("position", x_coordinate: 0, y_coordinate: 2)
        end
        let(:expected_cardinal) { "WEST" }

        before do
          robot.place(0, 2, "WEST")
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end
    end

    context "without having been placed" do
      let(:expected_position) { nil }
      let(:expected_cardinal) { nil }

      before { robot.move }

      it_should_behave_like "a robot at time of placement"
    end

    context "when there is a block in the way" do
      # Expect no coordinate change from original placement of 2, 2

      let(:expected_position) do
        double("position", x_coordinate: 2, y_coordinate: 2)
      end

      before { robot.place(2, 2, "NORTH") }

      context "to the NORTH" do
        let(:expected_cardinal) { "NORTH" }

        before do
          robot.place_block
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end

      context "to the EAST" do
        let(:expected_cardinal) { "EAST" }

        before do
          robot.right
          robot.place_block
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end

      context "to the SOUTH" do
        let(:expected_cardinal) { "SOUTH" }

        before do
          2.times { robot.right }
          robot.place_block
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end

      context "to the WEST" do
        let(:expected_cardinal) { "WEST" }

        before do
          robot.left
          robot.place_block
          robot.move
        end

        it_should_behave_like "a robot at time of placement"
      end
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
      let(:expected_position) { nil }
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
          map: Map.new(robot).output,
          x_coordinate: 2,
          y_coordinate: 2,
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
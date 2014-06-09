shared_examples_for "a robot" do
  specify "model attributes" do
    should respond_to(:board)
    should respond_to(:position)
    should respond_to(:cardinal_direction)
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
    its(:board)  { should_not be_nil }
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

  describe "#place" do
    let(:expected_position) do
      double("position", x_coordinate: 2, y_coordinate: 2)
    end
    let(:expected_cardinal) { "NORTH" }

    before { robot.place(2, 2, "NORTH") }

    context "with a valid position and direction" do
      it_should_behave_like "a robot at time of placement"

      context "and then #place again validly" do
        let(:expected_position) do
          double("position", x_coordinate: 3, y_coordinate: 3)
        end
        let(:expected_cardinal) { "SOUTH" }

        before { robot.place(3, 3, "SOUTH") }

        it_should_behave_like "a robot at time of placement"
      end
    end

    context "with an invalid position" do
      # Expect no change from original placement of 2, 2, "NORTH"
      context "too far on the x axis" do
        context "to the east" do
          before { robot.place(5, 2, "NORTH") }
          it_should_behave_like "a robot at time of placement"
        end

        context "to the west" do
          before { robot.place(-1, 2, "NORTH") }
          it_should_behave_like "a robot at time of placement"
        end
      end

      context "too far on the y axis" do
        context "to the north" do
          before { robot.place(2, 5, "NORTH") }
          it_should_behave_like "a robot at time of placement"
        end

        context "to the south" do
          before { robot.place(2, -1, "NORTH") }
          it_should_behave_like "a robot at time of placement"
        end
      end
    end
  end

  describe "#move" do
    context "before a #place" do
      let(:expected_position) { nil }
      let(:expected_cardinal) { nil }

      before do
        allow(robot).to receive(:move).and_return(false)
        robot.move
      end

      it_should_behave_like "a robot at time of placement"
    end

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
  end

  describe "turning" do
    context "before a #place" do
      let(:expected_position) { nil }
      let(:expected_cardinal) { nil }

      before do
        allow(robot).to receive(:left).and_return(false)
        robot.left
      end

      it_should_behave_like "a robot at time of placement"
    end

    context "after a #place" do
      let(:direction) { robot.cardinal_direction }

      before { robot.place(2, 2, "NORTH") }

      subject { direction }

      valid_cardinals.each_with_index do |direction, index|
        context "then #left turning #{direction}" do
          let(:left_turns) { valid_cardinals.rotate(-1) }

          before do
            robot.cardinal_direction = direction
            robot.left
          end

          it { should == left_turns[index] }
        end

        context "then #right turning #{direction}" do
          let(:right_turns) { valid_cardinals.rotate }

          before do
            robot.cardinal_direction = direction
            robot.right
          end

          it { should == right_turns[index] }
        end
      end
    end
  end

  describe "#report" do
    let(:report) { robot.report }

    subject { report }

    context "before a #place" do
      let(:expected_report) { false }
      before { allow(robot).to receive(:report).and_return(false) }
      it { should == expected_report }
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
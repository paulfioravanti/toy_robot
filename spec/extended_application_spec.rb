require 'spec_helper'
require 'toy_robot'

describe ExtendedApplication do

  let(:application) { ExtendedApplication.new }

  subject { application }

  it_should_behave_like "an application"

  specify "model attributes" do
    should respond_to(:robots, :target_name, :response)
  end

  describe "initial state" do
    its(:board)              { should_not be_nil }
    its(:robots)             { should be_empty }
    its(:permitted_commands) { should == extended_permitted_commands }

    describe "usage message" do
      subject { application.usage.gsub(ansi_colors, '') }
      it { should == extended_usage_message }
    end
  end

  describe "validations" do
    context "for board" do
      before { application.instance_variable_set(:@board, nil) }
      it { should_not be_valid }
    end
  end

  describe "@robots" do
    subject { application.robots }

    context "after an unsuccessful PLACE" do
      before { application.route("PLACE -2,-2,NORTH") }
      it { should have(0).items }
    end

    context "after a successful PLACE" do
      before { application.route("PLACE 2,2,NORTH") }
      it { should have(1).items }
    end

    context "after two successful PLACEs" do
      before do
        application.route("PLACE 2,2,NORTH")
        application.route("PLACE 1,1,NORTH")
      end
      it { should have(2).items }
    end

    context "after attempting to PLACE a robot on top of another robot" do
      before do
        application.route("PLACE 2,2,NORTH")
        application.route("PLACE 2,2,NORTH")
      end
      it { should have(1).items }
    end

    context "after attempting to PLACE a robot on top of a block" do
      before do
        application.route("PLACE 2,2,NORTH")
        application.route("BLOCK")
        application.route("PLACE 2,3,NORTH")
      end
      it { should have(1).items }
    end
  end

  describe "#route" do
    let(:response) { application.route(instruction) }

    subject { response.gsub(ansi_colors, '') }

    context "when no instruction given" do
      let(:instruction) { "" }
      it { should == "" }
    end

    context "when instruction is not valid" do
      let(:instruction) { "$%&#" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "after a valid PLACE command" do
        before { application.route("PLACE 2,2,NORTH") }
        it { should == post_place_invalid_response }
      end
    end

    context "when instruction is well formed but not a valid robot command" do
      let(:instruction) { "PLACE 2,A,NORTH" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "after a valid PLACE command" do
        before { application.route("PLACE 2,2,NORTH") }
        it { should == post_place_invalid_response }
      end
    end

    shared_examples_for "PLACE on a board with another robot" do |robot_name|
      context "to a placeable location" do
        context "without specifying robot's name" do
          let(:instruction) { "PLACE 1,1,NORTH" }
          it { should == "Robot R2 placed at: 1,1,NORTH\n" }
        end

        context "specifying a new robot's name" do
          let(:instruction) { "PLACE 1,1,NORTH Cylon" }
          it { should == "Robot Cylon placed at: 1,1,NORTH\n" }
        end

        context "specifying the already placed robot's name" do
          let(:instruction) { "PLACE 1,1,NORTH #{robot_name}" }
          it { should == "Robot #{robot_name} placed at: 1,1,NORTH\n" }
        end
      end

      context "to an unplaceable location" do
        context "without specifying robot's name" do
          let(:instruction) { "PLACE -1,-1,NORTH" }
          it { should == "Robot R2 cannot be placed at: -1,-1\n" }
        end

        context "specifying a new robot's name" do
          let(:instruction) { "PLACE -1,-1,NORTH Cylon" }
          it { should == "Robot Cylon cannot be placed at: -1,-1\n" }
        end

        context "specifying the already placed robot's name" do
          let(:instruction) { "PLACE -1,-1,NORTH #{robot_name}" }
          it { should == "Robot #{robot_name} cannot be placed at: -1,-1\n" }
        end
      end
    end

    context "when valid PLACE command issued" do
      context "on an empty board" do
        context "to a placeable location" do
          context "without specifying robot's name" do
            let(:instruction) { "PLACE 2,2,NORTH" }
            it { should == "Robot R1 placed at: 2,2,NORTH\n" }
          end

          context "specifying robot's name" do
            let(:instruction) { "PLACE 2,2,NORTH Kryten" }
            it { should == "Robot Kryten placed at: 2,2,NORTH\n" }
          end
        end

        context "to an unplaceable location" do
          context "without specifying robot's name" do
            let(:instruction) { "PLACE -2,-2,NORTH" }

            specify do
              response.gsub(ansi_colors, '').should ==
                "Robot R1 cannot be placed at: -2,-2\n"\
                "Hint: PLACE a robot first.\n"
            end
          end

          context "specifying robot's name" do
            let(:instruction) { "PLACE -2,-2,NORTH Kryten" }

            specify do
              response.gsub(ansi_colors, '').should ==
                "Robot Kryten cannot be placed at: -2,-2\n"\
                "Hint: PLACE a robot first.\n"
            end
          end
        end
      end

      context "on a board with another robot" do
        context "that is named" do
          before { application.route("PLACE 2,2,NORTH, Kryten") }
          it_should_behave_like "PLACE on a board with another robot", "Kryten"
        end

        context "that is not named" do
          before { application.route("PLACE 2,2,NORTH") }
          it_should_behave_like "PLACE on a board with another robot", "R1"
        end
      end
    end

    context "when MOVE command issued" do
      let(:instruction) { "MOVE" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "with one robot on the board" do
        context "to a movable location" do
          context "without specifying robot name" do
            before { application.route("PLACE 2,2,NORTH") }
            it { should == "R1 moved forward to 2,3,NORTH\n" }
          end

          context "specifying robot name" do
            before { application.route("PLACE 2,2,NORTH R1") }
            it { should == "R1 moved forward to 2,3,NORTH\n" }
          end
        end

        context "to an unmovable location" do
          context "without specifying robot name" do
            before { application.route("PLACE 0,0,SOUTH") }
            it { should == "R1 cannot move to 0,-1\n" }
          end

          context "specifying robot name" do
            before { application.route("PLACE 0,0,SOUTH R1") }
            it { should == "R1 cannot move to 0,-1\n" }
          end
        end
      end

      context "with more than one robot on the board" do
        context "to a movable location" do
          before do
            application.route("PLACE 2,2,NORTH")
            application.route("PLACE 1,1,NORTH")
          end

          context "without specifying robot name" do
            specify do
             response.gsub(ansi_colors, '').should ==
               "Invalid Command.\n"\
               "Specify which robot to perform action.\n"
            end
          end

          context "specifying robot name" do
            let(:instruction) { "MOVE R1" }
            it { should == "R1 moved forward to 2,3,NORTH\n" }
          end
        end

        context "to an unmovable location" do
          before do
            application.route("PLACE 0,0,SOUTH")
            application.route("PLACE 1,1,NORTH")
          end

          context "without specifying robot name" do
            specify do
             response.gsub(ansi_colors, '').should ==
               "Invalid Command.\n"\
               "Specify which robot to perform action.\n"
            end
          end

          context "specifying robot name" do
            let(:instruction) { "MOVE R1" }
            it { should == "R1 cannot move to 0,-1\n" }
          end
        end
      end
    end

    context "when LEFT command issued" do
      let(:instruction) { "LEFT" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "with one robot on the board" do
        before { application.route("PLACE 2,2,NORTH") }

        context "without specifying robot name" do
          it { should == "R1 turned left. Current direction: WEST\n" }
        end

        context "specifying robot name" do
          let(:instruction) { "LEFT R1" }
          it { should == "R1 turned left. Current direction: WEST\n" }
        end
      end

      context "with more than one robot on the board" do
        before do
          application.route("PLACE 2,2,NORTH")
          application.route("PLACE 1,1,NORTH")
        end

        context "without specifying robot name" do
          specify do
           response.gsub(ansi_colors, '').should ==
             "Invalid Command.\n"\
             "Specify which robot to perform action.\n"
          end
        end

        context "specifying robot name" do
          let(:instruction) { "LEFT R1" }
          it { should == "R1 turned left. Current direction: WEST\n" }
        end
      end
    end

    context "when RIGHT command issued" do
      let(:instruction) { "RIGHT" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "with one robot on the board" do
        before { application.route("PLACE 2,2,NORTH") }

        context "without specifying robot name" do
          it { should == "R1 turned right. Current direction: EAST\n" }
        end

        context "specifying robot name" do
          let(:instruction) { "RIGHT R1" }
          it { should == "R1 turned right. Current direction: EAST\n" }
        end
      end

      context "with more than one robot on the board" do
        before do
          application.route("PLACE 2,2,NORTH")
          application.route("PLACE 1,1,NORTH")
        end

        context "without specifying robot name" do
          specify do
           response.gsub(ansi_colors, '').should ==
             "Invalid Command.\n"\
             "Specify which robot to perform action.\n"
          end
        end

        context "specifying robot name" do
          let(:instruction) { "RIGHT R1" }
          it { should == "R1 turned right. Current direction: EAST\n" }
        end
      end
    end

    context "when SPIN command issued" do
      let(:instruction) { "SPIN" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "with one robot on the board" do
        before { application.route("PLACE 2,2,NORTH") }

        context "without specifying robot name" do
          it { should == "R1 spun around. Current direction: SOUTH\n" }
        end

        context "specifying robot name" do
          let(:instruction) { "SPIN R1" }
          it { should == "R1 spun around. Current direction: SOUTH\n" }
        end
      end

      context "with more than one robot on the board" do
        before do
          application.route("PLACE 2,2,NORTH")
          application.route("PLACE 1,1,NORTH")
        end

        context "without specifying robot name" do
          specify do
           response.gsub(ansi_colors, '').should ==
             "Invalid Command.\n"\
             "Specify which robot to perform action.\n"
          end
        end

        context "specifying robot name" do
          let(:instruction) { "SPIN R1" }
          it { should == "R1 spun around. Current direction: SOUTH\n" }
        end
      end
    end

    context "when REPORT command issued" do
      let(:instruction) { "REPORT" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "with one robot on the board" do
        before { application.route("PLACE 2,2,NORTH") }

        context "without specifying robot name" do
          it { should == extended_robot_2_2_north_report_no_name }
        end

        context "specifying robot name" do
          let(:instruction) { "REPORT R1" }
          it { should == extended_robot_2_2_north_report_no_name }
        end
      end

      context "with more than one robot on the board" do
        before do
          application.route("PLACE 2,2,NORTH")
          application.route("PLACE 1,1,NORTH")
        end

        context "without specifying robot name" do
          specify do
           response.gsub(ansi_colors, '').should ==
             "Invalid Command.\n"\
             "Specify which robot to perform action.\n"
          end
        end

        context "specifying robot name" do
          let(:instruction) { "REPORT R1" }
          it { should == extended_robot_2_2_north_report_no_name }
        end
      end
    end

    context "when BLOCK command issued" do
      let(:instruction) { "BLOCK" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "with one robot on the board" do
        before { application.route("PLACE 2,2,NORTH") }

        context "without specifying robot name" do
          it { should == "R1 placed Block at: 2,3\n" }
        end

        context "specifying robot name" do
          let(:instruction) { "BLOCK R1" }
          it { should == "R1 placed Block at: 2,3\n" }
        end
      end

      context "with more than one robot on the board" do
        before do
          application.route("PLACE 2,2,NORTH")
          application.route("PLACE 1,1,NORTH")
        end

        context "without specifying robot name" do
          specify do
           response.gsub(ansi_colors, '').should ==
             "Invalid Command.\n"\
             "Specify which robot to perform action.\n"
          end
        end

        context "specifying robot name" do
          let(:instruction) { "BLOCK R1" }
          it { should == "R1 placed Block at: 2,3\n" }
        end
      end

      context "when the position is already filled" do
        before { application.route("PLACE 2,2,NORTH") }

        context "with a robot's own block" do
          before { application.route("BLOCK") }
          it { should == "R1 cannot place Block at: 2,3\n" }
        end

        context "with another robot" do
          let(:instruction) { "BLOCK R1" }

          before do
            application.route("PLACE 2,3,SOUTH")
            application.route("BLOCK R1")
          end

          it { should == "R1 cannot place Block at: 2,3\n" }
        end

        context "with another robot's block" do
          let(:instruction) { "BLOCK R1" }

          before do
            application.route("PLACE 2,4,SOUTH")
            application.route("BLOCK R2")
          end

          it { should == "R1 cannot place Block at: 2,3\n" }
        end
      end
    end

    context "when MAP command issued" do
      let(:instruction) { "MAP" }

      context "on an empty board" do
        it { should == empty_application_map }
      end

      context "with one robot on the board" do
        before { application.route("PLACE 2,2,NORTH") }
        it { should == one_robot_application_map }

        context "that has blocks" do
          before do
            application.route("PLACE 2,2,SOUTH R1")
            4.times do
              application.route("BLOCK")
              application.route("RIGHT")
            end
          end
          it { should == one_robot_with_blocks_application_map }
        end
      end

      context "with multiple robots on the map" do
        before do
          application.route("PLACE 1,1,EAST")
          application.route("PLACE 3,3,WEST")
        end
        it { should == two_robots_application_map }

        context "that have blocks" do
          before do
            4.times do
              application.route("BLOCK R1")
              application.route("RIGHT R1")
              application.route("BLOCK R2")
              application.route("RIGHT R2")
            end
          end
          it { should == two_robots_with_blocks_application_map }
        end
      end

      context "with <ROBOT_NAME> argument" do
        let(:instruction) { "MAP R1" }

        context "on an empty board" do
          it { should == pre_place_invalid_response }
        end

        context "specifying an invalid robot" do
          let(:instruction) { "MAP INVALID" }
          it { should == pre_place_invalid_response }
        end

        context "with one robot on the board" do
          before { application.route("PLACE 2,2,NORTH") }
          it { should == one_robot_r1_map }

          context "that has blocks" do
            before do
              4.times do
                application.route("BLOCK")
                application.route("RIGHT")
              end
            end
            it { should == one_robot_r1_with_blocks_map }
          end

          context "specifying an invalid robot" do
            let(:instruction) { "MAP INVALID" }
            it { should == post_place_invalid_response }
          end
        end

        context "with multiple robots on the map" do
          before do
            application.route("PLACE 1,1,NORTH")
            application.route("PLACE 3,3,SOUTH")
          end

          context "R1's map" do
            it { should == two_robots_r1_map }
          end

          context "R2's map" do
            let(:instruction) { "MAP R2" }
            it { should == two_robots_r2_map }
          end

          context "that have blocks" do
            before do
              4.times do
                application.route("BLOCK R1")
                application.route("RIGHT R1")
                application.route("BLOCK R2")
                application.route("RIGHT R2")
              end
            end

            context "R1's map" do
              it { should == two_robots_r1_with_blocks_map }
            end

            context "R2's map" do
              let(:instruction) { "MAP R2" }
              it { should == two_robots_r2_with_blocks_map }
            end
          end
        end
      end

      context "with BOARD argument" do
        let(:instruction) { "MAP BOARD" }

        context "on an empty board" do
          it { should == empty_board_map }
        end

        context "with one robot on the board" do
          before { application.route("PLACE 2,2,NORTH") }
          it { should == one_robot_r1_board_map }

          context "that has blocks" do
            before do
              4.times do
                application.route("BLOCK")
                application.route("RIGHT")
              end
            end
            it { should == one_robot_r1_with_blocks_board_map }
          end
        end

        context "with multiple robots on the map" do
          before do
            application.route("PLACE 1,1,NORTH")
            application.route("PLACE 3,3,SOUTH")
          end
          it { should == two_robots_board_map }

          context "that have blocks" do
            before do
              4.times do
                application.route("BLOCK R1")
                application.route("RIGHT R1")
                application.route("BLOCK R2")
                application.route("RIGHT R2")
              end
            end
            it { should == two_robots_with_blocks_board_map }
          end
        end
      end
    end
  end

  describe "edge cases" do
    let(:response) { application.route("MAP") }

    subject { response.gsub(ansi_colors, '') }

    describe "a board with 25 robots" do
      before do
        cardinals = valid_cardinals
        (0..4).to_a.product((0..4).to_a) do |x_coord, y_coord|
          application.route("PLACE #{x_coord},#{y_coord},#{cardinals.first}")
          cardinals.rotate!
        end
      end

      it { should == twenty_five_robot_board }
    end

    describe "a board with one robot and 24 blocks" do
      before do
        (0..3).to_a.product((0..4).to_a) do |x_coord, y_coord|
          application.route("PLACE #{x_coord + 1},#{y_coord},WEST R1")
          application.route("BLOCK")
        end
        [4].product((1..4).to_a) do |x_coord, y_coord|
          application.route("PLACE #{x_coord},#{y_coord},SOUTH R1")
          application.route("BLOCK")
        end
      end
      it { should == one_robot_twenty_four_blocks }
    end
  end
end
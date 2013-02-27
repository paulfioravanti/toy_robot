require 'spec_helper'
require 'toy_robot'

describe ExtendedApplication do

  let(:application) { ExtendedApplication.new }

  subject { application }

  it_should_behave_like "an application"

  describe "initial state" do
    its(:permitted_commands) { should == extended_permitted_commands }
    its(:usage)              { should == extended_usage_message }
  end

  describe "#route" do
    let(:response) { application.route(instruction) }

    subject { response }

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

    context "when valid PLACE command issued" do
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
        context "before a valid PLACE command" do
          context "without specifying robot's name" do
            let(:instruction) { "PLACE -2,-2,NORTH" }

            specify do
              response.should == "Robot R1 cannot be placed at: -2,-2\n"\
                                 "Hint: PLACE robot first.\n"
            end
          end

          context "specifying robot's name" do
            let(:instruction) { "PLACE -2,-2,NORTH Kryten" }

            specify do
              response.should == "Robot Kryten cannot be placed at: -2,-2\n"\
                                 "Hint: PLACE robot first.\n"
            end
          end
        end

        # These tests need to be refactored if mutiple robots can move
        # board
        context "after a valid PLACE command" do
          context "without specifying robot's name" do
            let(:instruction) { "PLACE -2,-2,NORTH" }
            before { application.route("PLACE 2,2,NORTH") }
            it { should == "Robot R1 cannot be placed at: -2,-2\n" }
          end

          context "specifying then not specifying robot's name" do
            let(:instruction) { "PLACE -2,-2,NORTH" }
            before { application.route("PLACE 2,2,NORTH Kryten") }
            it { should == "Robot Kryten cannot be placed at: -2,-2\n" }
          end

          context "specifying robot's name" do
            let(:instruction) { "PLACE -2,-2,NORTH Kryten" }
            before { application.route("PLACE 2,2,NORTH Kryten") }
            it { should == "Robot Kryten cannot be placed at: -2,-2\n" }
          end

          context "not specifying then specifying robot's name" do
            let(:instruction) { "PLACE -2,-2,NORTH Kryten" }
            before { application.route("PLACE 2,2,NORTH") }
            it { should == "Robot R1 cannot be placed at: -2,-2\n" }
          end
        end
      end
    end

    context "when MOVE command issued" do
      let(:instruction) { "MOVE" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "after a valid PLACE command" do
        context "to a movable location" do
          before { application.route("PLACE 2,2,NORTH") }
          it { should == "R1 moved forward to 2,3,NORTH\n" }
        end

        context "to an unmovable location" do
          before { application.route("PLACE 0,0,SOUTH") }
          it { should == "R1 cannot move to 0,-1\n" }
        end
      end
    end

    context "when LEFT command issued" do
      let(:instruction) { "LEFT" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "after a valid PLACE command" do
        before { application.route("PLACE 2,2,NORTH") }
        it { should == "R1 turned left. Current direction: WEST\n" }
      end
    end

    context "when RIGHT command issued" do
      let(:instruction) { "RIGHT" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "after a valid PLACE command" do
        before { application.route("PLACE 2,2,NORTH") }
        it { should == "R1 turned right. Current direction: EAST\n" }
      end
    end

    context "when SPIN command issued" do
      let(:instruction) { "SPIN" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "after a valid PLACE command" do
        before { application.route("PLACE 2,2,NORTH") }
        it { should == "R1 spun around. Current direction: SOUTH\n" }
      end
    end

    context "when REPORT command issued" do
      let(:instruction) { "REPORT" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "after a valid PLACE command" do
        before { application.route("PLACE 2,2,NORTH") }
        it { should == extended_robot_2_2_north_report_no_name }
      end
    end

    context "when BLOCK command issued" do
      let(:instruction) { "BLOCK" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "after a valid PLACE command" do
        before { application.route("PLACE 2,2,NORTH") }
        it { should == "R1 placed Block at: 2,3\n" }
      end

      context "when there is already a block at position" do
        before do
          application.route("PLACE 2,2,NORTH")
          application.route("BLOCK")
        end

        it { should == "R1 cannot place Block at: 2,3\n" }
      end
    end

    context "when MAP command issued" do
      context "by itself do" do
        let(:instruction) { "MAP" }

        context "before a valid PLACE command" do
          it { should == pre_place_invalid_response }
        end

        context "after a valid PLACE command" do
          before { application.route("PLACE 2,2,NORTH") }
          it { should == robot_2_2_north_map }
        end
      end

      context "with BOARD argument" do
        let(:instruction) { "MAP BOARD" }

        context "before a valid PLACE command" do
          it { should == pre_place_invalid_response }
        end

        context "after a valid PLACE command" do
          before { application.route("PLACE 2,2,NORTH") }
          it { should == robot_2_2_north_board_map }
        end
      end
    end
  end
end
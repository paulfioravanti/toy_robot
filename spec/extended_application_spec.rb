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
        let(:instruction) { "PLACE 2,2,NORTH" }
        it { should == "Robot placed at: 2,2,NORTH\n" }
      end

      context "to an unplaceable location" do
        context "before a valid PLACE command" do
          let(:instruction) { "PLACE -2,-2,NORTH" }

          specify do
           response.should == "Robot cannot be placed at: -2,-2\n"\
                              "Hint: PLACE robot first.\n"
          end
        end

        context "after a valid PLACE command" do
          let(:instruction) { "PLACE -2,-2,NORTH" }
          before { application.route("PLACE 2,2,NORTH") }
          it { should == "Robot cannot be placed at: -2,-2\n" }
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
          it { should == "Robot moved forward to 2,3,NORTH\n" }
        end

        context "to an unmovable location" do
          before { application.route("PLACE 0,0,SOUTH") }
          it { should == "Robot cannot move to 0,-1\n" }
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
        it { should == "Robot turned left. Current direction: WEST\n" }
      end
    end

    context "when RIGHT command issued" do
      let(:instruction) { "RIGHT" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "after a valid PLACE command" do
        before { application.route("PLACE 2,2,NORTH") }
        it { should == "Robot turned right. Current direction: EAST\n" }
      end
    end

    context "when REPORT command issued" do
      let(:instruction) { "REPORT" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "after a valid PLACE command" do
        before { application.route("PLACE 2,2,NORTH") }
        it { should == extended_robot_2_2_north_report }
      end
    end

    context "when BLOCK command issued" do
      let(:instruction) { "BLOCK" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "after a valid PLACE command" do
        before { application.route("PLACE 2,2,NORTH") }
        it { should == "Block placed at 2,3\n" }
      end

      context "when there is already a block at position" do
        before do
          application.route("PLACE 2,2,NORTH")
          application.route("BLOCK")
        end
        it { should == "Block cannot be placed at 2,3\n" }
      end
    end

    context "when MAP command issued" do
      let(:instruction) { "MAP" }

      context "before a valid PLACE command" do
        it { should == pre_place_invalid_response }
      end

      context "after a valid PLACE command" do
        before { application.route("PLACE 2,2,NORTH") }
        it { should == robot_2_2_north_map }
      end
    end
  end
end
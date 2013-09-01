require 'spec_helper'
require 'toy_robot'

describe Application do

  let(:application) { Application.new }

  it_behaves_like "an application"

  # describe "initial state" do
  #   its(:permitted_commands) { should == permitted_commands }
  #   its(:usage)              { should == usage_message }
  # end

  describe "#route" do
    let(:response) { application.route(instruction) }

    subject { response }

    context "when no instruction given" do
      let(:instruction) { "" }
      it "is blank" do
        expect(response).to be_blank
      end
    end

    context "when instruction is not valid" do
      let(:instruction) { "$%&#" }
      it "is blank" do
        expect(response).to be_blank
      end
    end

    context "when instruction is valid but command is not" do
      let(:instruction) { "PLACE 2,A,NORTH" }
      it "is blank" do
        expect(response).to be_blank
      end
    end

    context "when command is valid, but issued before a PLACE command" do
      non_place_instructions.each do |instruction|
        context "for non-PLACE command: #{instruction}" do
          let(:instruction) { instruction }
          it "is blank" do
            expect(response).to be_blank
          end
        end
      end
    end

    context "when valid PLACE command issued" do
      let(:instruction) { "PLACE 2,2,NORTH" }
      it "is an array" do
        expect(response).to be_a_kind_of(Array) # Robot successfully placed
      end
    end

    context "when REPORT command issued post-PLACE" do
      let(:instruction) { "REPORT" }
      let(:place_command) { "PLACE 2,2,NORTH" }
      let(:report) { "2,2,NORTH\n" }

      before { application.route(place_command) }

      it "reports the robot's position" do
        expect(response).to eq(report)
      end
    end
  end
end
require 'spec_helper'
require 'toy_robot'

describe Application do

  let(:application) { Application.new }

  subject { application }

  it_should_behave_like "an application"

  describe "initial state" do
    its(:permitted_commands) { should == permitted_commands }
    its(:usage)              { should == usage_message }
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
      it { should == "" }
    end

    context "when instruction is valid but not a valid robot command" do
      let(:instruction) { "PLACE 2,A,NORTH" }
      it { should == "" }
    end

    context "when valid PLACE command issued" do
      let(:instruction) { "PLACE 2,2,NORTH" }
      it { should be_a_kind_of(Array) }
    end

    context "when REPORT command issued post-PLACE" do
      let(:instruction) { "REPORT" }
      before { application.route("PLACE 2,2,NORTH") }
      it { should == robot_2_2_north_report }
    end

    non_place_instructions.each do |instruction|
      context "with argless command" do
        let(:instruction) { instruction }
        it { should == "" }
      end
    end
  end
end
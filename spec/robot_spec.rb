require 'spec_helper'
# require 'toy_robot'

describe Robot do

  let(:board) { Board.new }
  let(:robot) { Robot.new(board) }

  subject { robot }

  it_should_behave_like "a robot"

  describe "#report" do
    let(:report) { robot.report }

    subject { report }

    context "after a #place" do
      let(:expected_report) { "2,2,NORTH\n" }
      before { robot.place(2, 2, "NORTH") }
      it { should == expected_report }
    end
  end
end
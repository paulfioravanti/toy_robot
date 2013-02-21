# encoding: UTF-8

require 'spec_helper'
require 'toy_robot'

describe Robot do

  let(:robot) { Robot.new(Board.new) }

  subject { robot }

  it_should_behave_like "a robot"

  describe "#report" do
    let(:report) { robot.report }

    subject { report }

    context "after a #place" do
      let(:expected_report) { robot_2_2_north_report }
      before { robot.place(2, 2, "NORTH") }
      it { should == expected_report }
    end
  end
end
require 'spec_helper'
require 'toy_robot_spec'

describe Robot do

  let(:robot) { Robot.new }

  subject { robot }

  describe "model attributes" do
    it { should respond_to(:current_x) }
    it { should respond_to(:current_y) }
    it { should respond_to(:direction) }
  end

  describe "initial state" do
    it { should be_valid }
  end

  describe "instance methods" do
    it { should respond_to(:report).with(0).arguments }
  end

  describe "validations" do
    context "when direction is invalid" do
      before { robot.direction = "INVALID" }
      it { should_not be_valid }
    end
  end

  describe "reporting" do
    before do
      robot.current_x = 0
      robot.current_y = 0
      robot.direction = "NORTH"
    end

    its(:report) do
      should == { current_x: 0, current_y: 0, direction: "NORTH" }
    end
  end

end
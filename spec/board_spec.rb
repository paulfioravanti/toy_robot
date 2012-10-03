require 'spec_helper'
require 'toy_robot'

describe Board do

  let(:board) do
    Board.new(left_boundary: 0, right_boundary: 4,
              top_boundary: 4, bottom_boundary: 0)
  end

  subject { board }

  describe "model attributes" do
    it { should respond_to(:left_boundary) }
    it { should respond_to(:right_boundary) }
    it { should respond_to(:top_boundary) }
    it { should respond_to(:bottom_boundary) }
  end

  describe "initial state" do
    it { should be_valid }
    its(:left_boundary) { should == 0 }
    its(:right_boundary) { should == 4 }
    its(:top_boundary) { should == 4 }
    its(:bottom_boundary) { should == 0 }
  end

  describe "instance methods" do
    it { should respond_to(:within_boundaries?).with(2).arguments }
  end

  describe "validations" do
    context "when boundaries are not integers" do
      boundary_variables.each do |boundary|
        before { board.instance_variable_set(boundary, "invalid") }
        it { should_not be_valid }
      end
    end

    context "when boundaries are not present" do
      boundary_variables.each do |boundary|
        before { board.instance_variable_set(boundary, nil) }
        it { should_not be_valid }
      end
    end
  end
end
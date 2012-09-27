require 'spec_helper'
require 'toy_robot_spec'

describe Board do

  let(:board) { Board.new(0, 4, 0, 4) }

  subject { board }

  describe "model attributes" do
    it { should respond_to(:left_boundary_x) }
    it { should respond_to(:right_boundary_x) }
    it { should respond_to(:top_boundary_y) }
    it { should respond_to(:bottom_boundary_y) }
  end

  describe "initial state" do
    it { should be_valid }
    its(:left_boundary_x) { should == 0 }
    its(:right_boundary_x) { should == 4 }
    its(:top_boundary_y) { should == 0 }
    its(:bottom_boundary_y) { should == 4 }
  end

  describe "validations" do
    context "when left_boundary_x is not an integer" do
      before { board.instance_variable_set(:@left_boundary_x, "invalid") }
      it { should_not be_valid }
    end

    context "when left_boundary_x is not an integer" do
      before { board.instance_variable_set(:@right_boundary_x, "invalid") }
      it { should_not be_valid }
    end

    context "when left_boundary_x is not an integer" do
      before { board.instance_variable_set(:@top_boundary_y, "invalid") }
      it { should_not be_valid }
    end

    context "when left_boundary_x is not an integer" do
      before { board.instance_variable_set(:@bottom_boundary_y, "invalid") }
      it { should_not be_valid }
    end
  end

end
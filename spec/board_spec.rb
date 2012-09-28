require 'spec_helper'
require 'toy_robot'

describe Board do

  let(:board) { Board.new(0, 4, 4, 0) }

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
    its(:top_boundary_y) { should == 4 }
    its(:bottom_boundary_y) { should == 0 }
  end

  describe "instance methods" do

  end

  describe "validations" do
    context "when boundaries are not integers" do
      boundary_variables.each do |boundary|
        before { board.instance_variable_set(boundary, "invalid") }
        it { should_not be_valid }
      end
    end
  end

end
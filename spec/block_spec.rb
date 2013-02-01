require 'spec_helper'
require 'toy_robot'

describe Block do

  let(:block) { Block.new(2, 3) }

  subject { block }

  specify "model attributes" do
    should respond_to(:x_position)
    should respond_to(:y_position)
  end

  describe "initial state" do
    let(:expected_x) { 2 }
    let(:expected_y) { 3 }

    it { should be_valid }
    its(:x_position) { should == expected_x }
    its(:y_position) { should == expected_y }
  end

  describe "validations" do
    context "for x_position, y_position" do
      context "when they are not integers" do
        coordinate_values.each do |coordinate|
          before { block.instance_variable_set(coordinate, "invalid") }
          it { should_not be_valid }
        end
      end

      context "when they are nil" do
        coordinate_values.each do |coordinate|
          before { block.instance_variable_set(coordinate, nil) }
          it { should_not be_valid }
        end
      end
    end
  end
end
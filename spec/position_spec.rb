require 'spec_helper'
require 'toy_robot'

describe Position do

  let(:position) { Position.new(2, 3) }

  subject { position }

  specify "model attributes" do
    should respond_to(:x_coordinate)
    should respond_to(:y_coordinate)
  end

  describe "initial state" do
    let(:expected_x) { 2 }
    let(:expected_y) { 3 }

    it { should be_valid }
    its(:x_coordinate) { should == expected_x }
    its(:y_coordinate) { should == expected_y }
  end

  describe "validations" do
    context "for x_coordinate, y_coordinate" do
      context "when they are not integers" do
        position_values.each do |coordinate|
          before { position.instance_variable_set(coordinate, "invalid") }
          it { should_not be_valid }
        end
      end

      context "when they are nil" do
        position_values.each do |coordinate|
          before { position.instance_variable_set(coordinate, nil) }
          it { should_not be_valid }
        end
      end
    end
  end
end
require 'spec_helper'
require 'toy_robot'

describe Block do

  let(:position) { Position.new(2, 3) }
  let(:block) { Block.new(position) }

  subject { block }

  specify "model attributes" do
    should respond_to(:position)
  end

  describe "initial state" do
    it { should be_valid }

    context "of its position" do
      let(:expected_x) { 2 }
      let(:expected_y) { 3 }

      subject { block.position }

      its(:x_coordinate) { should == expected_x }
      its(:y_coordinate) { should == expected_y }
    end
  end

  describe "validations" do
    context "for position" do
      context "when it is nil" do
        before { block.instance_variable_set(:@position, nil) }
        it { should_not be_valid }
      end
    end
  end
end
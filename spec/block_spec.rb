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

  describe "#<=>" do
    subject { block <=> other_block }
    context "for lesser positioned blocks" do
      let(:other_block) { Block.new(Position.new(1, 3)) }
      it { should == 1 }
    end

    context "for equally positioned blocks" do
      let(:other_block) { Block.new(Position.new(2, 3)) }
      it { should == 0 }
    end
    context "for greater positioned blocks" do
      let(:other_block) { Block.new(Position.new(3, 3)) }
      it { should == -1 }
    end
  end
end
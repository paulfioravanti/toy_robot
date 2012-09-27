require 'spec_helper'
require 'toy_robot'

describe ToyRobot do
  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end
end

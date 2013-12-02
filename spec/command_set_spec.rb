require 'spec_helper'

describe CommandSet do
  let(:command_set) { CommandSet.new }

  it_behaves_like "a command set" do
    let(:robot_interface) { [:left, :move, :place, :report, :right] }
  end
end
require 'spec_helper'

describe CommandSet do
  let(:command_set) { CommandSet.new }

  specify "attributes" do
    expect(command_set).to respond_to(:commands)
  end

  describe "commands" do
    let(:commands) { command_set.commands }
    let(:number_of_commands) { 5 }
    let(:robot_interface) { [:left, :move, :place, :report, :right] }

    it "has five commands" do
      expect(commands.size).to eq(number_of_commands)
    end

    specify "commands reflect the robot interface" do
      expect(commands.keys.sort).to eq(robot_interface)
    end
  end

  it_behaves_like "a command set"
end
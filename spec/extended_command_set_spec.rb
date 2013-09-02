require 'spec_helper'

describe ExtendedCommandSet do
  let(:command_set) { ExtendedCommandSet.new }

  specify "attributes" do
    expect(command_set).to respond_to(:commands)
  end

  describe "commands" do
    let(:commands) { command_set.commands }
    let(:number_of_commands) { 8 }
    let(:robot_interface) do
      [:block, :left, :map, :move, :place, :report, :right, :spin]
    end

    it "has eight commands" do
      expect(commands.size).to eq(number_of_commands)
    end

    specify "commands reflect the robot interface" do
      expect(commands.keys.sort).to eq(robot_interface)
    end
  end

  it_behaves_like "a command set"
end
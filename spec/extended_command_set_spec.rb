require 'spec_helper'

describe ExtendedCommandSet do
  let(:command_set) { ExtendedCommandSet.new }

  it_behaves_like "a command set" do
    let(:robot_interface) do
      [:block, :left, :map, :move, :place, :report, :right, :spin]
    end
  end
end
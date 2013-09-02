require 'spec_helper'

describe ExtendedUsage do
  let(:usage) { ExtendedUsage.message.gsub(ansi_colors, '') }
  let(:message) do
    "*** EXTENDED MODE ***\n"\
    "Valid Commands:\n"\
    "New Robot:\n"\
    "  PLACE X,Y,F [<ROBOT_NAME>]\n"\
    "Re-place Robot:\n"\
    "  PLACE X,Y,F <ROBOT_NAME>\n"\
    "MOVE [<ROBOT_NAME>]\n"\
    "LEFT [<ROBOT_NAME>]\n"\
    "RIGHT [<ROBOT_NAME>]\n"\
    "REPORT [<ROBOT_NAME>]\n"\
    "SPIN [<ROBOT_NAME>]\n"\
    "BLOCK [<ROBOT_NAME>]\n"\
    "MAP [<ROBOT_NAME>] [BOARD]\n"\
    "HELP\n"\
    "EXIT\n"\
    "-------\n"
  end

  it "builds the usage message" do
    expect(usage).to eq(message)
  end
end
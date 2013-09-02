require 'spec_helper'

describe Usage do
  let(:usage) { Usage.message }
  let(:message) do
    "Valid Commands:\n"\
    "PLACE X,Y,F eg: PLACE 0,0,NORTH\n"\
    "MOVE\n"\
    "LEFT\n"\
    "RIGHT\n"\
    "REPORT\n"\
    "EXIT\n"\
    "-------\n"
  end

  it "builds the usage message" do
    expect(usage).to eq(message)
  end
end
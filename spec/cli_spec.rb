require 'spec_helper'

describe CLI do

  let(:cli) { CLI.new }

  subject { cli }

  describe "model attributes" do
    it { should respond_to(:instructions) }
  end

  describe "instance methods" do
    it { should respond_to(:execute) }
  end

  describe "executing instructions from a file" do
    let(:default_file) { "instructions.txt" }
    let(:output) { capture(:stdout) { cli.execute } }

    context "containing valid test data" do
      valid_test_data.each do |data|
        it "should parse the file contents and output a result" do
          File.stub(:readlines).with(default_file) { StringIO.new(data[:input]) }
          output.should == data[:output]
        end
      end
    end

    context "containing invalid test data" do
      invalid_test_data.each do |data|
        it "should parse the file contents and output a result" do
          File.stub(:readlines).with(default_file) { StringIO.new(data[:input]) }
          output.should == data[:output]
        end
      end
    end
  end
end
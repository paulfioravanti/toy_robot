require 'spec_helper'

describe CLI do

  let(:cli) { CLI.new }

  subject { cli }

  it "model attributes" do
    should respond_to(:robot, :command, :args, :output)
  end

  it "instance methods" do
    should respond_to(:execute)
  end

  describe "#execute with options[:filename]" do
    let(:default_file) { "instructions.txt" }
    let(:output) { capture(:stdout) { cli.execute } }

    shared_examples_for "commands executed from a file" do
      it "parses the file contents and output a result" do
        cli.stub(:options) { { filename: default_file } }
        File.stub(:readlines).with(default_file) do
          StringIO.new(input).map { |line| line.strip.chomp }
        end
        output.should == expected_output
      end
    end

    context "with valid test data" do
      valid_test_data.each do |data|
        let(:input) { data[:input] }
        let(:expected_output) { data[:output] }

        it_should_behave_like "commands executed from a file"
      end
    end

    context "with invalid test data" do
      invalid_test_data.each do |data|
        let(:input) { data[:input] }
        let(:expected_output) { data[:output] }

        it_should_behave_like "commands executed from a file"
      end
    end
  end

  describe "#execute without options[:filename]" do
    let(:output) { capture(:stdout) { cli.execute } }

    it "shows a command prompt" do
      cli.stub(:gets) { "EXIT" }
      output.should include(prompt)
    end

    it "shows the usage message" do
      cli.stub(:gets) { "EXIT" }
      output.should include(usage)
    end

    shared_examples_for "commands executed from the command line" do
      it "processes the commands and output the results" do
        cli.stub(:gets).and_return(*commands, "EXIT")
        expected_output.split(/\n/).each do |value|
          output.should include(value)
        end
      end
    end

    context "with valid commands" do
      valid_test_data.each do |data|
        let(:expected_output) { data[:output] }
        let(:commands) { StringIO.new(data[:input]).map { |a| a.strip } }

        it_should_behave_like "commands executed from the command line"
      end
    end

    context "with invalid commands" do
      invalid_test_data.each do |data|
        let(:expected_output) { data[:output] }
        let(:commands) { StringIO.new(data[:input]).map { |a| a.strip } }

        it_should_behave_like "commands executed from the command line"
      end
    end
  end
end
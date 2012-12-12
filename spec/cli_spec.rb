require 'spec_helper'

describe CLI do

  let(:cli) { CLI.new }

  subject { cli }

  specify "model attributes" do
    should respond_to(:robot, :command, :args, :output)
  end

  specify "instance methods" do
    should respond_to(:execute)
  end

  describe "#execute with options[:filename]" do
    let(:default_file) { "instructions.txt" }
    let(:output) { capture(:stdout) { cli.execute } }

    shared_examples_for "commands executed from a file" do
      subject { output }

      before do
        cli.stub(:options) { { filename: default_file } }
        File.stub(:readlines).with(default_file) do
          StringIO.new(input).map { |line| line.strip.chomp }
        end
      end

      it { should == expected_output }
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

    describe "initial output" do
      subject { output }

      before { cli.stub(:gets) { "EXIT" } }

      it { should include(prompt) }
      it { should include(usage) }
    end


    shared_examples_for "commands executed from the command line" do
      subject { output }
      before do
        cli.stub(:gets).and_return(*commands, "EXIT")
      end

      it "outputs a prompt and the result for each command" do
        expected_output.split(/\n/).each do |value|
          output.should include(prompt << value)
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
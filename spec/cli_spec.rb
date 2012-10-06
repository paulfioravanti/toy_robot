require 'spec_helper'

describe CLI do

  let(:cli) { CLI.new }

  subject { cli }

  describe "instance methods" do
    it { should respond_to(:execute) }
  end

  describe "executing instructions from a file" do
    let(:default_file) { "instructions.txt" }
    let(:output) { capture(:stdout) { cli.execute } }

    shared_examples_for "all command executions from a file" do
      it "should parse the file contents and output a result" do
        cli.stub(:options) { { filename: default_file } }
        File.stub(:readlines).with(default_file) do
          StringIO.new(input).map { |a| a.strip.chomp }
        end
        output.should == expected_output
      end
    end

    context "containing valid test data" do
      valid_test_data.each do |data|
        let(:input) { data[:input] }
        let(:expected_output) { data[:output] }

        it_should_behave_like "all command executions from a file"
      end
    end

    context "containing invalid test data" do
      invalid_test_data.each do |data|
        let(:input) { data[:input] }
        let(:expected_output) { data[:output] }

        it_should_behave_like "all command executions from a file"
      end
    end
  end

  describe "executing instructions from the command line" do
    let(:output) { capture(:stdout) { cli.execute } }

    it "should contain a command prompt" do
      cli.stub(:gets) { "EXIT" }
      output.should include(prompt)
    end

    it "should contain the command usage message" do
      cli.stub(:gets) { "EXIT" }
      output.should include(usage)
    end

    shared_examples_for "all command executions from the command line" do
      it "should process the commands and output the results" do
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

        it_should_behave_like "all command executions from the command line"
      end
    end

    context "with invalid commands" do
      invalid_test_data.each do |data|
        let(:expected_output) { data[:output] }
        let(:commands) { StringIO.new(data[:input]).map { |a| a.strip } }

        it_should_behave_like "all command executions from the command line"
      end
    end
  end
end
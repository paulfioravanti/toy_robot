require 'spec_helper'
require 'toy_robot'

describe CLI do

  let(:cli) { CLI.new }

  subject { cli }

  specify "model attributes" do
    should respond_to(:robot, :command, :args, :response)
  end

  specify "instance methods" do
    should respond_to(:execute)
  end

  shared_examples_for "commands executed from a file" do |extended|
    subject { output }

    before do
      cli.stub(:options) { { extended: extended, file: default_file } }
      File.stub(:readlines).with(default_file) do
        StringIO.new(input).map { |line| line.strip.chomp }
      end
    end

    it { should == expected_output.join }
  end

  describe "#execute with options[:file]" do
    let(:output) { capture(:stdout) { cli.execute } }

    context "on a valid file" do
      let(:default_file) { "instructions.txt" }

      context "with valid test data" do
        context "in standard mode" do
          standard_valid_test_commands.each do |data|
            let(:input) { data[:input] }
            let(:expected_output) { data[:output] }

            it_should_behave_like "commands executed from a file", false
          end
        end

        context "in extended mode" do
          extended_valid_test_commands.each do |data|
            let(:input) { data[:input] }
            let(:expected_output) { data[:output] }

            it_should_behave_like "commands executed from a file", true
          end
        end
      end

      context "with invalid test data" do
        invalid_test_commands.each do |data|
          let(:input) { data[:input] }
          let(:expected_output) { data[:output] }

          it_should_behave_like "commands executed from a file"
        end
      end
    end

    context "on an invalid file" do
      let(:default_file) { "invalid" }
      let(:expected_output) do
        "Filename not specified or does not exist.\n"
      end

      subject { output }

      before { cli.stub(:options) { { file: default_file } } }

      it { should == expected_output }
    end
  end

  shared_examples_for "commands executed from the command line" do
    subject { output }
    before do
      cli.stub(:gets).and_return(*commands, "EXIT")
    end

    it "outputs a prompt and the result for each command" do
      expected_output.each do |value|
        output.should include(value)
      end
    end
  end

  describe "#execute without options[:file]" do
    let(:output) { capture(:stdout) { cli.execute } }

    describe "initial output" do
      subject { output }

      context "in standard mode" do

        before do
          cli.stub(:options) { { extended: false } }
          cli.stub(:gets) { "EXIT" }
        end

        it { should include(prompt) }
        it { should include(usage_standard) }
      end

      context "in extended mode" do

        before do
          cli.stub(:options) { { extended: true } }
          cli.stub(:gets) { "EXIT" }
        end

        it { should include(prompt) }
        it { should include(usage_extended) }
      end
    end

    context "with valid commands" do
      context "in standard mode" do
        before { cli.stub(:options) { { extended: false } } }

        standard_valid_test_commands.each do |data|
          let(:commands) { StringIO.new(data[:input]).map { |a| a.strip } }
          let(:expected_output) { data[:output] }

          it_should_behave_like "commands executed from the command line"
        end
      end

      context "in extended mode" do
        before { cli.stub(:options) { { extended: true } } }

        extended_valid_test_commands.each do |data|
          let(:commands) { StringIO.new(data[:input]).map { |a| a.strip } }
          let(:expected_output) { data[:output] }

          it_should_behave_like "commands executed from the command line"
        end
      end
    end

    context "with invalid commands" do
      invalid_test_commands.each do |data|
        let(:commands) { StringIO.new(data[:input]).map { |a| a.strip } }
        let(:expected_output) { data[:output] }

        it_should_behave_like "commands executed from the command line"
      end
    end
  end
end
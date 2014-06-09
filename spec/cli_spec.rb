require 'spec_helper'
require 'toy_robot'

describe CLI do

  let(:cli) { CLI.new }

  subject { cli }

  specify "model attributes" do
    should respond_to(:application)
  end

  specify "instance methods" do
    should respond_to(:execute)
  end

  shared_examples_for "commands executed from a file" do |extended|
    before do
      allow(cli).to receive(:options).and_return(
        { extended: extended, file: default_file }
      )
      allow(File).to receive(:readlines).with(default_file) do
        StringIO.new(input).map { |line| line.strip.chomp }
      end
    end

    it { should == expected_output }
  end

  describe "#execute with options[:file]" do
    let(:output) { capture(:stdout) { cli.execute } }

    subject { output.gsub(ansi_colors, '') }

    context "on a valid file" do
      let(:default_file) { "instructions.txt" }

      context "with valid test data" do
        valid_test_commands.each do |data|
          context "in standard mode" do
            let(:input) { data[:input] }
            let(:expected_output) { data[:output].join }
            it_should_behave_like "commands executed from a file", false
          end
        end

        extended_valid_test_commands.each do |data|
          context "in extended mode" do
            let(:input) { data[:input] }
            let(:expected_output) { data[:output].join }
            it_should_behave_like "commands executed from a file", true
          end
        end
      end

      context "with invalid test data" do
        invalid_test_commands.each do |data|
          context "in standard mode" do
            let(:input) { data[:input] }
            let(:expected_output) { data[:output].join }
            it_should_behave_like "commands executed from a file", false
          end
        end

        extended_invalid_test_commands.each do |data|
          context "in extended mode" do
            let(:input) { data[:input] }
            let(:expected_output) { data[:output].join }
            it_should_behave_like "commands executed from a file", true
          end
        end
      end
    end

    context "on an invalid file" do
      let(:default_file) { "invalid" }
      let(:expected_output) do
        "Filename not specified or does not exist.\n"
      end

      before do
        allow(cli).to \
          receive(:options).and_return({ file: default_file })
      end

      subject { output.gsub(ansi_colors, '') }
      it { should == expected_output }
    end
  end

  shared_examples_for "commands executed from the command line" do |extended|
    before do
      allow(cli).to receive(:options).and_return({ extended: extended })
      allow(cli).to receive(:gets).and_return(*commands, "EXIT")
    end

    subject { output.gsub(ansi_colors, '') }

    it "outputs the result for each command" do
      expected_output.each do |value|
        expect(output.gsub(ansi_colors, '')).to include(value)
      end
    end
  end

  describe "#execute without options[:file]" do
    let(:output) { capture(:stdout) { cli.execute } }

    describe "initial output" do
      before { allow(cli).to receive(:gets).and_return("EXIT") }

      context "in standard mode" do
        before do
          allow(cli).to receive(:options).and_return({ extended: false })
        end
        subject { output.gsub(ansi_colors, '') }
        it { should == usage_message << prompt }
      end

      context "in extended mode" do
        before do
          allow(cli).to receive(:options).and_return({ extended: true })
        end
        subject { output.gsub(ansi_colors, '') }
        it { should == extended_usage_message << prompt }
      end
    end

    describe "HELP command" do
      before do
        allow(cli).to receive(:gets).and_return("HELP", "EXIT")
      end

      context "in standard mode" do
        before do
          allow(cli).to receive(:options).and_return({ extended: false })
        end
        subject { output.gsub(ansi_colors, '') }
        it { should == usage_message << prompt << prompt }
      end

      context "in extended mode" do
        before do
          allow(cli).to receive(:options).and_return({ extended: true })
        end
        subject { output.gsub(ansi_colors, '') }
        it { should == (extended_usage_message << prompt) * 2 }
      end
    end

    context "with robot valid commands" do
      valid_test_commands.each do |data|
        context "in standard mode" do
          let(:commands) { StringIO.new(data[:input]).map { |a| a.strip } }
          let(:expected_output) { data[:output] }
          it_should_behave_like "commands executed from the command line", false
        end
      end

      extended_valid_test_commands.each do |data|
        context "in extended mode" do
          let(:commands) { StringIO.new(data[:input]).map { |a| a.strip } }
          let(:expected_output) { data[:output] }
          it_should_behave_like "commands executed from the command line", true
        end
      end
    end

    context "with invalid commands" do
      invalid_test_commands.each do |data|
        context "in standard mode" do
          let(:commands) { StringIO.new(data[:input]).map { |a| a.strip } }
          let(:expected_output) { data[:output] }
          it_should_behave_like "commands executed from the command line", false
        end
      end

      extended_invalid_test_commands.each do |data|
        context "in extended mode" do
          let(:commands) { StringIO.new(data[:input]).map { |a| a.strip } }
          let(:expected_output) { data[:output] }
          it_should_behave_like "commands executed from the command line", true
        end
      end
    end
  end
end
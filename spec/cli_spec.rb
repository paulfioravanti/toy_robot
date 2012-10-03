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

    context "containing valid test data" do
      valid_test_data.each do |data|
        expected_output = data[:output]

        it "should parse the file contents and output a result" do
          cli.stub(:options) { { filename: default_file } }
          File.stub(:readlines).with(default_file) do
            StringIO.new(data[:input]).map { |a| a.strip.chomp }
          end
          output.should == expected_output
        end
      end
    end

    context "containing invalid test data" do
      invalid_test_data.each do |data|
        expected_output = data[:output]

        it "should parse the file contents and output a result" do
          cli.stub(:options) { { filename: default_file } }
          File.stub(:readlines).with(default_file) do
            StringIO.new(data[:input]).map { |a| a.strip.chomp }
          end
          output.should == expected_output
        end
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

    # context "with valid commands" do
    #   valid_test_data.each do |data|
    #     let(:expected_output) { data[:output] }
    #     let(:commands) { StringIO.new(data[:input]).map { |a| a.strip } }

    #     it "should process the commands and output the results" do

    #     end
    #   end
    # end

    # context "with invalid commands" do

    # end

  end

end
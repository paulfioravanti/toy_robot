shared_examples_for "an application" do

  specify "model attributes" do
    should respond_to(:robot)
    should respond_to(:permitted_commands)
    should respond_to(:usage)
    should respond_to(:command)
    should respond_to(:args)
  end

  specify "instance methods" do
    should respond_to(:route).with(1).argument
  end

  describe "initial state" do
    it { should be_valid }
  end

  describe "validations" do
    context "for permitted_commands" do
      before { application.instance_variable_set(:@permitted_commands, nil) }
      it { should_not be_valid }
    end

    context "for usage" do
      before { application.instance_variable_set(:@usage, nil) }
      it { should_not be_valid }
    end
  end
end
shared_examples_for 'an application' do

  specify 'model attributes' do
    expect(application).to respond_to(
      :board,
      :robot,
      :permitted_commands,
      :usage,
      :command,
      :args
    )
  end

  specify 'instance methods' do
    expect(application).to respond_to(:route).with(1).argument
  end

  describe 'initial state' do
    it 'has a board' do
      expect(application.board).to be_present
    end

    it 'has a set of permitted commands' do
      expect(application.permitted_commands).to be_present
    end

    it 'has a usage message' do
      expect(application.usage).to be_present
    end
  end

  # describe "initial state" do
  #   it { should be_valid }
  # end

  # describe "validations" do
  #   context "for permitted_commands" do
  #     before { application.instance_variable_set(:@permitted_commands, nil) }
  #     it { should_not be_valid }
  #   end

  #   context "for usage" do
  #     before { application.instance_variable_set(:@usage, nil) }
  #     it { should_not be_valid }
  #   end
  # end
end
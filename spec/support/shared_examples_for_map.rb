shared_examples_for "a map" do
  specify "model attributes" do
    should respond_to(:x_range, :y_range, :output)
  end

  describe "initial state" do
    it { should be_valid }
  end

  describe "validations" do
    context "for x_range" do
      context "when it is nil" do
        before { map.instance_variable_set(:@x_range, nil) }
        it { should_not be_valid }
      end
    end

    context "for y_range" do
      context "when it is nil" do
        before { map.instance_variable_set(:@y_range, nil) }
        it { should_not be_valid }
      end
    end
  end
end
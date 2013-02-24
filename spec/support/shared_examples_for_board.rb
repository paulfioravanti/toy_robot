shared_examples_for "a board" do

  specify "model attributes" do
    should respond_to(:left_boundary)
    should respond_to(:right_boundary)
    should respond_to(:top_boundary)
    should respond_to(:bottom_boundary)
  end

  specify "instance methods" do
    should respond_to(:within_boundaries?).with(1).argument
  end

  describe "initial state" do
    it { should be_valid }
    its(:left_boundary) { should == 0 }
    its(:right_boundary) { should == 4 }
    its(:top_boundary) { should == 4 }
    its(:bottom_boundary) { should == 0 }
  end

  describe "validations" do
    context "for boundaries" do
      boundaries.each do |boundary|
        context "when #{boundary} is not an integer" do
          before { board.instance_variable_set(boundary, "invalid") }
          it { should_not be_valid }
        end
      end

      boundaries.each do |boundary|
        context "when #{boundary} is not present" do
          before { board.instance_variable_set(boundary, nil) }
          it { should_not be_valid }
        end
      end
    end
  end
end
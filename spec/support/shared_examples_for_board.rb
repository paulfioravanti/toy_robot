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
      context "when they are not integers" do
        boundaries.each do |boundary|
          before { board.instance_variable_set(boundary, "invalid") }
          it { should_not be_valid }
        end
      end

      context "when they are not present" do
        boundaries.each do |boundary|
          before { board.instance_variable_set(boundary, nil) }
          it { should_not be_valid }
        end
      end
    end
  end
end
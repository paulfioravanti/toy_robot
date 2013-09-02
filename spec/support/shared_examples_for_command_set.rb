shared_examples_for "a command set" do
  describe "#contains?" do
    let(:result) { command_set.contains?(command) }

    context "when command is contained in command set" do
      let(:command) { :place }
      it "returns true" do
        expect(result).to be_true
      end
    end

    context "when command is not contained in command set" do
      let(:command) { :derp }
      it "returns false" do
        expect(result).to be_false
      end
    end
  end

  describe "#args_size_for" do
    let(:result) { command_set.args_size_for(command) }

    context "for a command" do
      let(:command) { :place }
      let(:args_size_for_place) { 3 }

      it "returns the args size of the command" do
        expect(result).to eq(args_size_for_place)
      end
    end

    context "for an aliased command" do
      let(:command) { :left }
      let(:args_size_for_move) { 0 }

      it "returns the args size of the aliased command" do
        expect(result).to eq(args_size_for_move)
      end
    end
  end

  describe "#conditions_for" do
    let(:result) { command_set.conditions_for(command) }

    context "for a command" do
      let(:command) { :place }
      let(:conditions_for_place) do
        ['coordinates_numerical?', 'valid_cardinal?']
      end

      it "returns the args size of the command" do
        expect(result).to eq(conditions_for_place)
      end
    end

    context "for an aliased command" do
      let(:command) { :left }
      let(:conditions_for_move) { ['placed?'] }

      it "returns the args size of the aliased command" do
        expect(result).to eq(conditions_for_move)
      end
    end
  end
end
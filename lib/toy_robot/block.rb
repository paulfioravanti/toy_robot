require 'active_model'

module ToyRobot
  # A block that can be placed by the Toy Robot on the Board
  class Block
    include ActiveModel::Validations
    # include Enumerable

    attr_reader :position

    validates :position, presence: true

    def initialize(position)
      @position = position
    end

    def <=>(other_block)
      @position <=> other_block.position
    end
  end
end
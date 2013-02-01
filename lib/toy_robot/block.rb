require 'active_model'

module ToyRobot
  # A block that can be placed by the Toy Robot on the Board
  class Block
    include ActiveModel::Validations

    attr_reader :position

    validates :position, presence: true

    def initialize(position)
      @position = position
    end
  end
end
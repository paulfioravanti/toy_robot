require 'active_model'

module ToyRobot
  # A block that can be placed by the Toy Robot on the Board
  class Block
    include ActiveModel::Validations

    attr_reader :x_position, :y_position

    validates :x_position, numericality: { only_integer: true }
    validates :y_position, numericality: { only_integer: true }

    def initialize(x_pos, y_pos)
      @x_position, @y_position = x_pos, y_pos
    end
  end
end
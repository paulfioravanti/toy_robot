require 'active_model'
require 'toy_robot/toy_robot_helper'

module ToyRobot
  class Robot
    include ActiveModel::Validations
    include ToyRobotHelper

    attr_reader   :board
    attr_accessor :x_position, :y_position, :cardinal_direction, :placed

    validates :board, presence: true
    validates :x_position, numericality: { only_integer: true },
                           allow_nil: true
    validates :y_position, numericality: { only_integer: true },
                           allow_nil: true
    VALID_CARDINAL_DIRECTIONS = %w(NORTH EAST SOUTH WEST)
    validates :cardinal_direction, inclusion: VALID_CARDINAL_DIRECTIONS,
                                   allow_nil: true
    validates :placed, inclusion: [true],
                       allow_nil: true

    def initialize
      @board = Board.new
    end

    def place(x, y, cardinal = @cardinal_direction)
      if numerical?(x, y)
        x, y, cardinal = x.to_i, y.to_i, cardinal.upcase
        if @board.within_boundaries?(x, y) &&
          VALID_CARDINAL_DIRECTIONS.include?(cardinal)
          @x_position, @y_position, @cardinal_direction = x, y, cardinal
          @placed ||= true
          return
        end
      end
    end

    def move
      if @placed
        x, y = calculate_move
        place(x, y)
      end
    end

    def left
      turn("left") if @placed
    end

    def right
      turn("right") if @placed
    end

    def report
      if @placed
        {
          x_position: @x_position,
          y_position: @y_position,
          cardinal_direction: @cardinal_direction
        }
      end
    end

    private

      def turn(direction)
        index = VALID_CARDINAL_DIRECTIONS.index(@cardinal_direction)
        @cardinal_direction = new_direction(direction, index)
        return
      end

      def new_direction(direction, index)
        turns = case direction
          when "left" then VALID_CARDINAL_DIRECTIONS.rotate(-1)
          when "right" then VALID_CARDINAL_DIRECTIONS.rotate
        end
        turns[index]
      end

      def calculate_move
        formula = case @cardinal_direction
          when "NORTH" then [@x_position, @y_position + 1]
          when "EAST"  then [@x_position + 1, @y_position]
          when "SOUTH" then [@x_position, @y_position - 1]
          when "WEST"  then [@x_position - 1, @y_position]
        end
      end
  end
end
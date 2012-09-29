require 'active_model'

module ToyRobot
  class Robot
    include ActiveModel::Validations

    attr_reader   :board
    attr_accessor :x_position, :y_position, :cardinal_direction

    validates :board, presence: true
    validates :x_position, numericality: { only_integer: true },
                           allow_nil: true
    validates :y_position, numericality: { only_integer: true },
                           allow_nil: true
    VALID_CARDINAL_DIRECTIONS = %w(NORTH EAST SOUTH WEST)
    validates :cardinal_direction, inclusion: VALID_CARDINAL_DIRECTIONS,
                                   allow_nil: true

    def initialize(board)
      @board = board
    end

    def place(x, y, cardinal=@cardinal_direction)
      if @board.within_boundaries?(x, y)
        @x_position, @y_position, @cardinal_direction = x, y, cardinal.upcase
      end
    end

    def move
      if placed?
        x, y = @x_position, @y_position
        eval(move_formula)
        place(x, y)
      end
    end

    def left
      turn if placed?
    end

    def right
      turn if placed?
    end

    def report
      if placed?
        {
          x_position: @x_position,
          y_position: @y_position,
          cardinal_direction: @cardinal_direction
        }
      end
    end

    private

      def turn
        # get name of calling method to determine direction to turn
        direction = caller[0][/`(.*)'/, 1]
        index = VALID_CARDINAL_DIRECTIONS.index(@cardinal_direction)
        @cardinal_direction = new_direction(direction, index)
      end

      def new_direction(direction, index)
        turns = case direction
          when "left" then VALID_CARDINAL_DIRECTIONS.rotate(-1)
          when "right" then VALID_CARDINAL_DIRECTIONS.rotate
        end
        turns[index]
      end

      def move_formula
        formula = case @cardinal_direction
          when "NORTH" then "y += 1"
          when "EAST"  then "x += 1"
          when "SOUTH" then "y -= 1"
          when "WEST"  then "x -= 1"
        end
      end

      def placed?
        [@x_position, @y_position, @cardinal_direction].each do |var|
          return false if var.nil?
        end
        true
      end

  end
end
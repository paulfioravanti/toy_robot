require 'active_model'

module ToyRobot
  # A Toy Robot that moves around a Board, without falling off it
  class Robot
    include ActiveModel::Validations

    attr_reader   :board
    attr_accessor :x_position, :y_position, :cardinal_direction, :placed

    validates :board, presence: true
    validates :x_position, numericality: { only_integer: true },
                           allow_nil: true
    validates :y_position, numericality: { only_integer: true },
                           allow_nil: true
    VALID_CARDINALS = %w(NORTH EAST SOUTH WEST)
    validates :cardinal_direction, inclusion: VALID_CARDINALS,
                                   allow_nil: true
    validates :placed, inclusion: [true],
                       allow_nil: true

    def initialize
      @board = Board.new
    end

    def place(x_position, y_position, cardinal = @cardinal_direction)
      x_position, y_position, cardinal =
        x_position.to_i, y_position.to_i, cardinal.upcase
      if @board.within_boundaries?(x_position, y_position) &&
        VALID_CARDINALS.include?(cardinal)
        @x_position, @y_position, @cardinal_direction =
          x_position, y_position, cardinal
        @placed ||= true
        return
      end
    end

    def move
      if @placed
        x_position, y_position = calculate_move
        place(x_position, y_position)
      end
    end

    def left
      turn("left")
    end

    def right
      turn("right")
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
        if @placed
          index = VALID_CARDINALS.index(@cardinal_direction)
          @cardinal_direction = case direction
            when "left" then VALID_CARDINALS.rotate(-1)[index]
            when "right" then VALID_CARDINALS.rotate[index]
          end
          return
        end
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
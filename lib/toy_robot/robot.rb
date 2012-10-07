require 'active_model'

module ToyRobot
  # A Toy Robot that moves around a Board, without falling off it
  class Robot
    include ActiveModel::Validations
    extend ActiveModel::Callbacks

    define_model_callbacks :command, only: :before

    before_command  :placed?

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
    validates :placed, inclusion: [true, false]

    def initialize
      @board = Board.new
      @placed = false
    end

    def place(x_pos, y_pos, cardinal)
      x_pos, y_pos, cardinal = x_pos.to_i, y_pos.to_i, cardinal.upcase
      if @board.within_boundaries?(x_pos, y_pos)
        @x_position, @y_position, @cardinal_direction = x_pos, y_pos, cardinal
        @placed = true
        return
      end
    end

    def move
      run_callbacks :command do
        x_pos, y_pos = calculate_move
        place(x_pos, y_pos, @cardinal_direction)
      end
    end

    def left
      run_callbacks :command do
        turn("left")
      end
    end

    def right
      run_callbacks :command do
        turn("right")
      end
    end

    def report
      run_callbacks :command do
        {
          x_position: @x_position,
          y_position: @y_position,
          cardinal_direction: @cardinal_direction
        }
      end
    end

    private

      def placed?
        return false unless @placed
      end

      def turn(direction)
        index = VALID_CARDINALS.index(@cardinal_direction)
        @cardinal_direction = case direction
          when "left" then VALID_CARDINALS.rotate(-1)[index]
          when "right" then VALID_CARDINALS.rotate[index]
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
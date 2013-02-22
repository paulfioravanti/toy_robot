require 'active_model'

require 'position'

module ToyRobot
  # A Toy Robot that moves around a Board, without falling off it
  class Robot
    include ActiveModel::Validations

    attr_reader   :board
    attr_accessor :position, :cardinal_direction

    validates :board, presence: true
    VALID_CARDINALS = %w(NORTH EAST SOUTH WEST)
    validates :cardinal_direction, inclusion: VALID_CARDINALS,
                                   allow_nil: true

    def initialize(board)
      @board = board
    end

    def place(x_pos, y_pos, cardinal)
      position = Position.new(x_pos.to_i, y_pos.to_i)
      cardinal = cardinal.upcase
      if placeable?(position)
        @position, @cardinal_direction = position, cardinal
      end
    end

    def move
      new_position = forward_position
      if placeable?(new_position)
        @position = new_position
      end
    end

    def left
      turn("left")
    end

    def right
      turn("right")
    end

    def report
      "#{robot_position}\n"
    end

    private

      def robot_position
        "#{@position.coordinates.join(',')},"\
        "#{@cardinal_direction}"
      end

      def placeable?(position)
        @board.within_boundaries?(position)
      end

      def turn(direction)
        index = VALID_CARDINALS.index(@cardinal_direction)
        @cardinal_direction = case direction
          when "left" then VALID_CARDINALS.rotate(-1)[index]
          when "right" then VALID_CARDINALS.rotate[index]
        end
        return
      end

      def forward_position
        x_coord, y_coord = @position.coordinates
        case @cardinal_direction
          when "NORTH" then Position.new(x_coord, y_coord + 1)
          when "EAST"  then Position.new(x_coord + 1, y_coord)
          when "SOUTH" then Position.new(x_coord, y_coord - 1)
          when "WEST"  then Position.new(x_coord - 1, y_coord)
        end
      end
  end
end
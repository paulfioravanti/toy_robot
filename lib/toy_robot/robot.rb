require 'active_model'

require 'board'
require 'block'
require 'position'
require 'map'

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

    def initialize
      @board = Board.new
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
      @position = new_position if placeable?(new_position)
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

  # A Toy Robot that moves around a Board, with extra functionality
  class ExtendedRobot < Robot

    attr_accessor :blocks

    def initialize
      super
      @blocks = []
    end

    def place(x_pos, y_pos, cardinal)
      position = Position.new(x_pos.to_i, y_pos.to_i)
      cardinal = cardinal.upcase
      if placeable?(position)
        @position, @cardinal_direction = position, cardinal
        "Robot placed at: #{robot_position}\n"
      else
        "Robot cannot be placed at: #{position.coordinates.join(',')}\n"
      end
    end

    def move
      new_position = forward_position
      if placeable?(new_position)
        @position = new_position
        "Robot moved forward to #{robot_position}\n"
      else
        "Robot cannot move to #{new_position.coordinates.join(',')}\n"
      end
    end

    def left
      super
      "Robot turned left. Current direction: #{@cardinal_direction}\n"
    end

    def right
      super
      "Robot turned right. Current direction: #{@cardinal_direction}\n"
    end

    def report
      "Robot Position: #{robot_position}\n"
    end

    def block
      block_position = forward_position
      place_block(block_position)
    end

    def map
      "#{Map.new(self).output}"\
      "Robot Position: #{robot_position}\n"
    end

    private

      def placeable?(position)
        super && space_empty?(position)
      end

      def space_empty?(position)
        @blocks.each do |block|
          if block.position == position
            return false
          end
        end
        true
      end

      def place_block(position)
        block_coordinates = position.coordinates.join(',')
        if placeable?(position)
          @blocks << Block.new(position)
          "Block placed at #{block_coordinates}\n"
        else
          "Block cannot be placed at #{block_coordinates}\n"
        end
      end
  end
end
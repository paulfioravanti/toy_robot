require 'active_model'

require 'position'
require 'block'
require 'map'

module ToyRobot
# A Toy Robot that moves around a Board, with extra functionality
  class ExtendedRobot < Robot

    attr_accessor :blocks

    def initialize(board)
      super(board)
      @blocks = []
    end

    def place(x_pos, y_pos, cardinal)
      new_position = Position.new(x_pos.to_i, y_pos.to_i)
      cardinal = cardinal.upcase
      if placeable?(new_position) || @position == new_position
        update_placement(new_position, cardinal)
        "Robot placed at: #{robot_position}\n"
      else
        "Robot cannot be placed at: #{new_position.coordinates.join(',')}\n"
      end
    end

    def move
      new_position = forward_position
      if placeable?(new_position)
        update_position(new_position)
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

    def spin
      index = VALID_CARDINALS.index(@cardinal_direction)
      @cardinal_direction = VALID_CARDINALS.rotate(2)[index]
      "Robot spun around. Current direction: #{@cardinal_direction}\n"
    end

    def report
      "Robot Position: #{robot_position}\n"
    end

    def block
      block_position = forward_position
      place_block(block_position)
    end

    def map
      map = "#{Map.new(self).output}"\
            "Robot Position: #{robot_position}\n"
      map << "Blocks at positions:\n#{block_positions}\n" unless @blocks.empty?
      map
    end

    private

      def placeable?(position)
        super && @board.space_empty?(position)
      end

      def update_position(new_position)
        if @position
          @board.change_position(@position, new_position)
        else
          @board.occupy(new_position)
        end
        @position = new_position
      end

      def update_placement(new_position, cardinal)
        update_position(new_position)
        @cardinal_direction = cardinal
      end

      def block_positions
        positions = @blocks.sort.map { |block| block.position.coordinates }
        positions.to_s[1...-1].chars.each_slice(24).map do |line|
          line.join.strip
        end.join("\n")
      end

      def place_block(position)
        block_coordinates = position.coordinates.join(',')
        if placeable?(position)
          @board.occupy(position)
          @blocks << Block.new(position)
          "Block placed at: #{block_coordinates}\n"
        else
          "Block cannot be placed at: #{block_coordinates}\n"
        end
      end
  end
end
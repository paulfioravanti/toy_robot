require 'active_model'

require 'position'
require 'block'
require 'robot_map'
require 'colorable'

module ToyRobot
  # A Toy Robot that moves around a Board, with extra functionality
  class ExtendedRobot < Robot
    include Colorable

    attr_accessor :blocks, :name

    def initialize(board, name)
      super(board)
      @name = name
      @blocks = []
    end

    def place(x_pos, y_pos, cardinal)
      new_position = Position.new(x_pos.to_i, y_pos.to_i)
      cardinal = cardinal.upcase
      if placeable?(new_position) || @position == new_position
        update_placement(new_position, cardinal)
        green "Robot #{@name} placed at: #{robot_position}\n"
      else
        red "Robot #{@name} cannot be placed at: "\
            "#{new_position.coordinates.join(',')}\n"
      end
    end

    def move
      new_position = forward_position
      if placeable?(new_position)
        update_position(new_position)
        green "#{@name} moved forward to #{robot_position}\n"
      else
        red "#{@name} cannot move to #{new_position.coordinates.join(',')}\n"
      end
    end

    def left
      super
      green "#{@name} turned left. Current direction: #{@cardinal_direction}\n"
    end

    def right
      super
      green "#{@name} turned right. Current direction: #{@cardinal_direction}\n"
    end

    def spin
      index = VALID_CARDINALS.index(@cardinal_direction)
      @cardinal_direction = VALID_CARDINALS.rotate(2)[index]
      green "#{@name} spun around. Current direction: #{@cardinal_direction}\n"
    end

    def report
      yellow "#{@name}'s Position: #{robot_position}\n"
    end

    def block
      block_position = forward_position
      place_block(block_position)
    end

    def map
      map = "#{RobotMap.new(self).output}"\
            "#{report}"
      map << "#{report_block_positions}" unless @blocks.empty?
      map
    end

    def report_block_positions
      coordinates = @blocks.sort.map { |block| block.position.coordinates }
      coord_sets = coordinates.to_s[1...-1].chars.each_slice(24).map do |line|
        line.join.strip
      end.join("\n")
      yellow "#{@name}'s Blocks at Positions:\n" << "#{coord_sets}\n"
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

      def place_block(position)
        block_coordinates = position.coordinates.join(',')
        if placeable?(position)
          @board.occupy(position)
          @blocks << Block.new(position)
          green "#{@name} placed Block at: #{block_coordinates}\n"
        else
          red "#{@name} cannot place Block at: #{block_coordinates}\n"
        end
      end
  end
end
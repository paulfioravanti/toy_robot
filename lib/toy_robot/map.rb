# encoding: UTF-8
require 'active_model'

module ToyRobot
  # A Visual Map of the board, with all the objects on it
  class Map
    include ActiveModel::Validations

    attr_reader :board, :x_range, :y_range,
                :robot_coordinates, :robot_direction,
                :block_coordinates, :output

    validates :x_range, presence: true
    validates :y_range, presence: true
    validates :robot_coordinates, presence: true
    validates :robot_direction, presence: true

    def initialize(robot)
      @board = robot.board
      initialize_board
      initialize_robot(robot)
      @block_coordinates = []
      if blocks = robot.blocks
        initialize_blocks(blocks)
      end
      @output = ""
      map_header
      map_content
    end

    private

      def spacer
        " "
      end

      def initialize_board
        @x_range = (@board.left_boundary..@board.right_boundary).to_a
        @y_range = (@board.bottom_boundary..@board.top_boundary).to_a.reverse
      end

      def initialize_robot(robot)
        @robot_coordinates = robot.position.coordinates
        @robot_direction = robot.cardinal_direction
      end

      def initialize_blocks(blocks)
        blocks.each do |block|
          @block_coordinates << block.position.coordinates
        end
      end

      def map_content
        line_start, line_end = @x_range.first, @x_range.last
        @y_range.product(@x_range) do |y_coord, x_coord|
          @output << "#{y_coord}" if x_coord == line_start
          @output << spacer + element_at([x_coord, y_coord])
          @output << "\n" if x_coord == line_end
        end
      end

      def map_header
        @x_range.each do |x_coord|
          @output << (spacer * 3) + "#{x_coord}"
        end
        @output << "\n"
      end

      def element_at(coordinates)
        if coordinates == @robot_coordinates
          output_robot_direction
        elsif @block_coordinates.include?(coordinates)
          "[X]"
        else
          "[ ]"
        end
      end

      def output_robot_direction
        case @robot_direction
          when "NORTH" then "[Λ]"
          when "EAST"  then "[>]"
          when "SOUTH" then "[V]"
          when "WEST"  then "[<]"
        end
      end
  end
end
# encoding: UTF-8
require 'active_model'

module ToyRobot
  # A Visual Map of the board, with all the objects on it
  class Map
    include ActiveModel::Validations

    attr_reader :robot, :x_range, :y_range,
                :block_coordinates, :output

    validates :robot, presence: true
    validates :x_range, presence: true
    validates :y_range, presence: true

    def initialize(robot)
      @robot = robot
      board = @robot.board
      @x_range = (board.left_boundary..board.right_boundary).to_a
      @y_range = (board.bottom_boundary..board.top_boundary).to_a.reverse
      @block_coordinates = []
      initialize_blocks
      @output = ""
      map_header
      map_content
    end

    private

      def spacer
        " "
      end

      def initialize_blocks
        if blocks = @robot.blocks
          blocks.each do |block|
            @block_coordinates << block.position.coordinates
          end
        end
      end

      def map_content
        line_start, line_end = @x_range.first, @x_range.last
        @y_range.product(@x_range) do |y_coord, x_coord|
          @output << "#{y_coord}" if x_coord == line_start
          @output << spacer + object_at([x_coord, y_coord])
          @output << "\n" if x_coord == line_end
        end
      end

      def map_header
        @x_range.each do |x_coord|
          @output << (spacer * 3) + "#{x_coord}"
        end
        @output << "\n"
      end

      def object_at(coordinates)
        if coordinates == @robot.position.coordinates
          output_robot_direction
        elsif @block_coordinates.include?(coordinates)
          "[X]"
        else
          "[ ]"
        end
      end

      def output_robot_direction
        case @robot.cardinal_direction
          when "NORTH" then "[Λ]"
          when "EAST"  then "[>]"
          when "SOUTH" then "[V]"
          when "WEST"  then "[<]"
        end
      end
  end
end
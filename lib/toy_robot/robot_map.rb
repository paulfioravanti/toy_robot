require 'active_model'
require 'mappable'

module ToyRobot
  # A Visual Map of the board, with all the objects on it
  class RobotMap
    include Mappable

    attr_reader :robot, :block_coordinates

    validates :robot, presence: true

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

      def initialize_blocks
        if blocks = @robot.blocks
          blocks.each do |block|
            @block_coordinates << block.position.coordinates
          end
        end
      end

      def object_at(coordinates)
        if coordinates == @robot.position.coordinates
          output_robot_direction
        elsif @block_coordinates.include?(coordinates)
          "[█]"
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
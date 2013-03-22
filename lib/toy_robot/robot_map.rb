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
          bold_white("[") + red("█") + bold_white("]")
        else
          bold_white("[ ]")
        end
      end

      def output_robot_direction
        left_bracket, right_bracket = bold_white("["), bold_white("]")
        case @robot.cardinal_direction
        when "NORTH" then left_bracket + bold_cyan("Λ") + right_bracket
        when "EAST"  then left_bracket + bold_cyan(">") + right_bracket
        when "SOUTH" then left_bracket + bold_cyan("V") + right_bracket
        when "WEST"  then left_bracket + bold_cyan("<") + right_bracket
        end
      end
  end
end
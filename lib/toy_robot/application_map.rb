require 'active_model'
require 'mappable'

module ToyRobot
  # A Visual Map of all objects on the board
  class ApplicationMap
    include Mappable

    attr_reader :application, :robot_coordinates, :block_coordinates, :blocks

    def initialize(application)
      @application = application
      board = @application.board
      @x_range = (board.left_boundary..board.right_boundary).to_a
      @y_range = (board.bottom_boundary..board.top_boundary).to_a.reverse
      @robot_coordinates = []
      @block_coordinates = []
      initialize_robots
      @output = ""
      map_header
      map_content
    end

    private

      def initialize_robots
        if robots = @application.robots
          robots.each do |robot|
            @robot_coordinates << robot.position.coordinates
            if @blocks = robot.blocks
              initialize_blocks
            end
          end
        end
      end

      def initialize_blocks
        @blocks.each do |block|
          @block_coordinates << block.position.coordinates
        end
      end

      def object_at(coordinates)
        if @robot_coordinates.include?(coordinates)
          output_robot_direction(coordinates)
        elsif @block_coordinates.include?(coordinates)
          bold_white("[") + red("█") + bold_white("]")
        else
          bold_white("[ ]")
        end
      end

      def output_robot_direction(coordinates)
        left_bracket, right_bracket = bold_white("["), bold_white("]")
        case @application.robots.find do |robot|
               robot.position.coordinates == coordinates
             end.cardinal_direction
        when "NORTH" then left_bracket + bold_cyan("Λ") + right_bracket
        when "EAST"  then left_bracket + bold_cyan(">") + right_bracket
        when "SOUTH" then left_bracket + bold_cyan("V") + right_bracket
        when "WEST"  then left_bracket + bold_cyan("<") + right_bracket
        end
      end
  end
end
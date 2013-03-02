# encoding: UTF-8
require 'active_model'
require 'mappable'

module ToyRobot
  # A Visual Map of all objects on the board
  class ApplicationMap
    include Mappable

    attr_reader :application, :robot_coordinates, :block_coordinates

    # validates :robot, presence: true

    def initialize(application)
      @application = application
      board = @application.board
      @x_range = (board.left_boundary..board.right_boundary).to_a
      @y_range = (board.bottom_boundary..board.top_boundary).to_a.reverse
      @robot_coordinates = []
      @block_coordinates = []
      initialize_robots
      # initialize_blocks
      @output = ""
      map_header
      map_content
    end

    private

      def initialize_robots
        if robots = @application.robots
          robots.each do |robot|
            @robot_coordinates << robot.position.coordinates
            if blocks = robot.blocks
              blocks.each do |block|
                @block_coordinates << block.position.coordinates
              end
            end
          end
        end
      end

      def object_at(coordinates)
        if @robot_coordinates.include?(coordinates)
          output_robot_direction(coordinates)
        elsif @block_coordinates.include?(coordinates)
          "[█]"
        else
          "[ ]"
        end
      end

      def output_robot_direction(coordinates)
        robot = @application.robots.find do |robot|
          robot.position.coordinates == coordinates
        end
        case robot.cardinal_direction
          when "NORTH" then "[Λ]"
          when "EAST"  then "[>]"
          when "SOUTH" then "[V]"
          when "WEST"  then "[<]"
        end
      end
  end
end
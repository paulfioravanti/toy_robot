require 'active_model'

module ToyRobot
  class Board
    include ActiveModel::Validations

    attr_reader :left_boundary_x, :right_boundary_x,
                :top_boundary_y, :bottom_boundary_y

    validates :left_boundary_x, numericality: { only_integer: true }
    validates :right_boundary_x, numericality: { only_integer: true }
    validates :top_boundary_y, numericality: { only_integer: true }
    validates :bottom_boundary_y, numericality: { only_integer: true }

    def initialize(left_x, right_x, top_y, bottom_y)
      @left_boundary_x = left_x
      @right_boundary_x = right_x
      @top_boundary_y = top_y
      @bottom_boundary_y = bottom_y
    end

    def place(robot, x_position, y_position, direction)
      if within_boundaries?(x_position, y_position)
        robot.current_x = x_position
        robot.current_y = y_position
        robot.current_direction = direction
      end
    end

    private

      def within_boundaries?(x, y)
        x >= @left_boundary_x &&
        x <= @right_boundary_x  &&
        y <= @top_boundary_y &&
        y >= @bottom_boundary_y
      end

  end
end
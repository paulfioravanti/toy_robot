require 'active_model'
require 'toy_robot/robot_helper'

module ToyRobot
  class Robot
    include ActiveModel::Validations
    include RobotHelper

    attr_accessor :current_x, :current_y, :direction

    # validates :direction, inclusion: valid_directions
    validates :direction, inclusion: %w(NORTH SOUTH EAST WEST),
                          allow_nil: true

    def report
      {
        current_x: @current_x,
        current_y: @current_y,
        direction: @direction
      }
    end

  end
end
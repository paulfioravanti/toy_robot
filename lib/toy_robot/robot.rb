require 'active_model'

module ToyRobot
  class Robot
    include ActiveModel::Validations

    VALID_DIRECTIONS = %w(NORTH EAST SOUTH WEST)

    attr_accessor :current_x, :current_y, :current_direction

    validates :current_x, numericality: { only_integer: true },
                          allow_nil: true
    validates :current_y, numericality: { only_integer: true },
                          allow_nil: true
    validates :current_direction, inclusion: VALID_DIRECTIONS,
                                  allow_nil: true

    def left
      turn
    end

    def right
      turn
    end

    def move

    end

    def report
      {
        current_x: @current_x,
        current_y: @current_y,
        current_direction: @current_direction
      }
    end

    private

      def turn
        # get name of calling method to determine direction to turn
        direction = caller[0][/`(.*)'/, 1]
        if direction == "left"
          valid_turns = VALID_DIRECTIONS.rotate(-1)
        elsif direction == "right"
          valid_turns = VALID_DIRECTIONS.rotate
        end
        index = VALID_DIRECTIONS.index(@current_direction)
        @current_direction = valid_turns[index]
      end

  end
end
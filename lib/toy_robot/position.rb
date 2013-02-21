require 'active_model'

module ToyRobot
  # A Position on a board
  class Position
    include ActiveModel::Validations

    attr_reader :x_coordinate, :y_coordinate

    validates :x_coordinate, presence: true,
                             numericality: { only_integer: true }
    validates :y_coordinate, presence: true,
                             numericality: { only_integer: true }

    def initialize(x_coord, y_coord)
      @x_coordinate, @y_coordinate = x_coord, y_coord
    end

    def coordinates
      [@x_coordinate, @y_coordinate]
    end

    def ==(other_position)
      @x_coordinate == other_position.x_coordinate &&
      @y_coordinate == other_position.y_coordinate
    end

    def <=>(other_position)
      other_x_coord = other_position.x_coordinate
      other_y_coord = other_position.y_coordinate
      if @x_coordinate == other_x_coord
        compare_y_coordinate(other_y_coord)
      elsif @x_coordinate > other_x_coord
        1
      else
        -1
      end
    end

    private

      def compare_y_coordinate(other_y_coord)
        if @y_coordinate == other_y_coord
          0
        elsif @y_coordinate > other_y_coord
          1
        else
          -1
        end
      end
  end
end
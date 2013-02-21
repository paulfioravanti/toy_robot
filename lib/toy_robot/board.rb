require 'active_model'

module ToyRobot
  # A Board that a Robot can roam around on
  class Board
    include ActiveModel::Validations

    attr_reader :left_boundary, :right_boundary,
                :top_boundary, :bottom_boundary

    validates :left_boundary,   presence: true,
                                numericality: { only_integer: true }
    validates :right_boundary,  presence: true,
                                numericality: { only_integer: true }
    validates :top_boundary,    presence: true,
                                numericality: { only_integer: true }
    validates :bottom_boundary, presence: true,
                                numericality: { only_integer: true }

    def initialize
      @left_boundary, @bottom_boundary = 0, 0
      @right_boundary, @top_boundary = 4, 4
    end

    def within_boundaries?(position)
      x_coord, y_coord = position.coordinates
      x_coord >= @left_boundary &&
      x_coord <= @right_boundary  &&
      y_coord <= @top_boundary &&
      y_coord >= @bottom_boundary
    end
  end

  # A slightly smarter Board
  class ExtendedBoard < Board

    attr_accessor :occupied_spaces

    def initialize
      super
      @occupied_spaces = []
    end

    def occupy(position)
      @occupied_spaces << position
    end

    def release(position)
      @occupied_spaces.delete(position)
    end

    def space_empty?(position)
      @occupied_spaces.include?(position) ? false : true
    end
  end
end
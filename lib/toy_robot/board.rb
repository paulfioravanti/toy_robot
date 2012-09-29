require 'active_model'

module ToyRobot
  class Board
    include ActiveModel::Validations

    attr_reader :left_boundary, :right_boundary,
                :top_boundary, :bottom_boundary

    validates :left_boundary, numericality: { only_integer: true }
    validates :right_boundary, numericality: { only_integer: true }
    validates :top_boundary, numericality: { only_integer: true }
    validates :bottom_boundary, numericality: { only_integer: true }

    def initialize(left_x, right_x, top_y, bottom_y)
      @left_boundary, @right_boundary = left_x, right_x
      @top_boundary, @bottom_boundary = top_y, bottom_y
    end

    def within_boundaries?(x, y)
      x >= @left_boundary &&
      x <= @right_boundary  &&
      y <= @top_boundary &&
      y >= @bottom_boundary
    end

  end
end
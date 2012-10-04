require 'active_model'

module ToyRobot
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

    def within_boundaries?(x, y)
      x >= @left_boundary &&
      x <= @right_boundary  &&
      y <= @top_boundary &&
      y >= @bottom_boundary
    end

  end
end
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

    def within_boundaries?(x_position, y_position)
      x_position >= @left_boundary &&
      x_position <= @right_boundary  &&
      y_position <= @top_boundary &&
      y_position >= @bottom_boundary
    end

  end
end
require 'active_model'

module ToyRobot
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
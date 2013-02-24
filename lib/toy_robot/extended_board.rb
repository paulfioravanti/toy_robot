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

    def change_position(old_position, new_position)
      release(old_position)
      occupy(new_position)
    end

    def space_empty?(position)
      @occupied_spaces.include?(position) ? false : true
    end

    private

      def release(position)
        @occupied_spaces.delete(position)
      end
  end
end
require 'active_model'

require 'board_map'
require 'colorable'

module ToyRobot
  # A slightly smarter Board
  class ExtendedBoard < Board
    include Colorable

    attr_accessor :occupied_positions

    def initialize
      super
      @occupied_positions = []
    end

    def occupy(position)
      @occupied_positions << position
    end

    def change_position(old_position, new_position)
      release(old_position)
      occupy(new_position)
    end

    def space_empty?(position)
      @occupied_positions.include?(position) ? false : true
    end

    def map
      map = "#{BoardMap.new(self).output}"\
            "#{yellow "Occupied Positions:"}\n"
      if @occupied_positions.empty?
        map << cyan("None\n")
      else
        map << yellow("#{output_occupied_positions}\n")
      end
      map
    end

    private

      def release(position)
        @occupied_positions.delete(position)
      end

      def output_occupied_positions
        positions = @occupied_positions.sort.map do |position|
          position.coordinates
        end
        positions.to_s[1...-1].chars.each_slice(24).map do |line|
          line.join.strip
        end.join("\n")
      end
  end
end
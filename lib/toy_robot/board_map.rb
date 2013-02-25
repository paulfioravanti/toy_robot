require 'active_model'
require 'mappable'

module ToyRobot
  # A Visual Map of the board, indicating occupied spaces
  class BoardMap
    include Mappable

    attr_reader :board, :object_coordinates

    validates :board, presence: true

    def initialize(board)
      @board = board
      @x_range = (@board.left_boundary..@board.right_boundary).to_a
      @y_range = (@board.bottom_boundary..@board.top_boundary).to_a.reverse
      @object_coordinates = []
      initialize_objects
      @output = ""
      map_header
      map_content
    end

    private

      def initialize_objects
        @board.occupied_positions.each do |space|
          @object_coordinates << space.coordinates
        end
      end

      def object_at(coordinates)
        if @object_coordinates.include?(coordinates)
          "[X]"
        else
          "[ ]"
        end
      end
  end
end
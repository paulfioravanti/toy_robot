require 'active_model'

module ToyRobot
  class Robot
    include ActiveModel::Validations
    # include ActiveModel::Conversion
    # extend ActiveModel::Naming

    attr_reader   :board#, :errors
    attr_accessor :x_position, :y_position, :cardinal_direction

    validates :board, presence: true
    validates :x_position, numericality: { only_integer: true },
                           allow_nil: true
    validates :y_position, numericality: { only_integer: true },
                           allow_nil: true
    VALID_CARDINAL_DIRECTIONS = %w(NORTH EAST SOUTH WEST)
    validates :cardinal_direction, inclusion: VALID_CARDINAL_DIRECTIONS,
                                   allow_nil: true

    def initialize(attributes = {})
      attributes.each do |name, value|
        instance_variable_set(:"@#{name}", value)
      end if attributes
      # @errors = ActiveModel::Errors.new(self)
    end

    # def persisted?
    #   false
    # end

    # def read_attribute_for_validation(attr)
    #   send(attr)
    # end

    # def self.human_attribute_name(attr, options = {})
    #   attr
    # end

    # def self.lookup_ancestors
    #   [self]
    # end

    def place(x, y, cardinal = @cardinal_direction)
      # p x, y
      # if ([x, y].each { |n| numerical?(n) })
      if numerical?(x) && numerical?(y)
        x, y, cardinal = x.to_i, y.to_i, cardinal.upcase
        # errors.delete(:coordinates)
        if @board.within_boundaries?(x, y) &&
          VALID_CARDINAL_DIRECTIONS.include?(cardinal)
            @x_position, @y_position, @cardinal_direction = x, y, cardinal
            nil
            # errors.clear
          # else
            # nil
            # errors.add(:cardinal_direction, "must be valid")
          # end
        # else
          # nil
          # errors.add(:x_position, "must be within board boundaries")
        end
      # else
        # nil
        # errors.add(:x_position, "must be integers")
      end
    end

    def move
      if placed?
        x, y = @x_position, @y_position
        eval(move_formula)
        place(x, y)
      # else
        # nil
      end
    end

    def left
      # placed? ? turn : nil
      turn if placed?
    end

    def right
      # placed? ? turn : nil
      turn if placed?
    end

    def report
      if placed?
        # errors.delete(:report)
        {
          x_position: @x_position,
          y_position: @y_position,
          cardinal_direction: @cardinal_direction
        }
      # else
        # errors.add(:report, "only given when placed correctly")
        # nil
      end

    end

    private

      def turn
        # get name of calling method to determine direction to turn
        direction = caller[0][/`(.*)'/, 1]
        index = VALID_CARDINAL_DIRECTIONS.index(@cardinal_direction)
        @cardinal_direction = new_direction(direction, index)
        return
      end

      def new_direction(direction, index)
        turns = case direction
          when "left" then VALID_CARDINAL_DIRECTIONS.rotate(-1)
          when "right" then VALID_CARDINAL_DIRECTIONS.rotate
        end
        turns[index]
      end

      def move_formula
        formula = case @cardinal_direction
          when "NORTH" then "y += 1"
          when "EAST"  then "x += 1"
          when "SOUTH" then "y -= 1"
          when "WEST"  then "x -= 1"
        end
      end

      def placed?
        [@x_position, @y_position, @cardinal_direction].each do |var|
          return false if var.nil?
        end
        true
      end

      def numerical?(object)
        true if Integer(object) rescue false
      end
  end
end
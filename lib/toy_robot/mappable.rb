module ToyRobot
  module Mappable

    attr_reader :x_range, :y_range, :output

    def self.included(base)
      base.send :include, ActiveModel::Validations
      base.send :validates ,:x_range, presence: true
      base.send :validates ,:y_range, presence: true
    end

    private

      def spacer
        " "
      end

      def map_header
        @x_range.each do |x_coord|
          @output << (spacer * 3) + "#{x_coord}"
        end
        @output << "\n"
      end

      def map_content
        line_start, line_end = @x_range.first, @x_range.last
        @y_range.product(@x_range) do |y_coord, x_coord|
          @output << "#{y_coord}" if x_coord == line_start
          @output << spacer + object_at([x_coord, y_coord])
          @output << "\n" if x_coord == line_end
        end
      end

  end
end
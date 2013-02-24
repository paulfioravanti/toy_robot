require 'active_model'

require 'extended_board'
require 'extended_robot'

module ToyRobot
  # Main application class for extended Toy Robot app
  class ExtendedApplication < Application

    attr_accessor :response

    def initialize
      super
      define_extended_rules
    end

    def route(instruction)
      return "" if instruction.rstrip.empty? # blank string
      @response = super
      process_response
    end

    private

      def define_extended_rules
        @permitted_commands += [
          {
            name: :block,
            args_size: 0,
            conditions: ['placed?']
          },
          {
            name: :map,
            args_size: 0,
            conditions: ['placed?']
          }
        ]
        @usage.insert(0,  "*** EXTENDED MODE ***\n")
        @usage.insert(93, "BLOCK\n"\
                          "MAP\n"\
                          "HELP\n")
      end

      def process_response
        @response << "Invalid Command.\n" if @response.empty?
        @response << "Hint: PLACE robot first.\n" unless placed?
        @response
      end
  end
end
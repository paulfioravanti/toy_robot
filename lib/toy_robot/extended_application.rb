require 'active_model'

require 'extended_board'
require 'extended_robot'

module ToyRobot
  # Main application class for extended Toy Robot app
  class ExtendedApplication < Application

    def initialize
      super
      define_extended_rules
    end

    def route(instruction)
      return "" if instruction == "\n" || instruction == ""
      response = super
      response = "Invalid Command.\n" if response == ""
      response << "Hint: PLACE robot first.\n" unless placed?
      response
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
  end
end
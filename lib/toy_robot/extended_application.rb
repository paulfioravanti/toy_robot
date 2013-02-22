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
      response = execute_instruction(instruction)
      response << "Hint: PLACE robot first.\n" unless placed?
      response
    end

    private

      def execute_instruction(instruction)
        if parse_instruction(instruction) && valid_robot_command?
          initialize_extended_world if @command == :place
          response = @robot.send(@command, *@args)
        else
          response = "Invalid Command.\n"
        end
      end

      def initialize_extended_world
        @board ||= ExtendedBoard.new
        @robot ||= ExtendedRobot.new(@board)
      end

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
                          "MAP\n")
      end
  end
end
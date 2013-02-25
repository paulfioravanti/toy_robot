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
      return "" if instruction.rstrip.empty?
      if parse_instruction(instruction) && valid_robot_command?
        initialize_world if !@board && @command == :place
        send_command
      else
        @response = ""
      end
      process_response
    end

    private

      def initialize_world
        @board ||= ExtendedBoard.new
        @robot ||= ExtendedRobot.new(@board)
      end

      def send_command
        if @command == :map && @args_size == 1
          @response = @board.send(@command)
        else
          @response = @robot.send(@command, *@args)
        end
      end

      def define_extended_rules
        @permitted_commands.merge!({
          spin: {
            args_size: 0,
            conditions: ['placed?']
          },
          block: {
            args_size: 0,
            conditions: ['placed?']
          },
          map: {
            args_size: (0..1),
            conditions: ['placed?', 'valid_map_type?']
          }
        })
        @usage.insert(0,  "*** EXTENDED MODE ***\n")
        @usage.insert(93, "SPIN\n"\
                          "BLOCK\n"\
                          "MAP [BOARD]\n"\
                          "HELP\n")
      end

      def process_response
        @response << "Invalid Command.\n" if @response.empty?
        @response << "Hint: PLACE robot first.\n" unless placed?
        @response
      end

      def valid_map_type?
        if @args_size == 1
          return false unless @args[0].to_s.match(/BOARD/i)
        end
        true
      end
  end
end
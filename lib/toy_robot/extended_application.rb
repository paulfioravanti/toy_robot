require 'active_model'

require 'extended_board'
require 'extended_robot'

module ToyRobot
  # Main application class for extended Toy Robot app
  class ExtendedApplication < Application

    attr_accessor :response, :args_size, :robot_name

    def initialize
      super
      define_extended_rules
    end

    def route(instruction)
      return "" if instruction.rstrip.empty?
      execute_instruction(instruction)
      process_response
    end

    private

      def execute_instruction(instruction)
        if parse_instruction(instruction) && valid_robot_command?
          extract_robot_name
          initialize_world if !@board && @command == :place
          send_command
        else
          @response = ""
        end
      end

      def initialize_world
        @board = ExtendedBoard.new
        @robot = ExtendedRobot.new(@board, @robot_name)
      end

      def extract_robot_name
        @robot_name = if @args_size == 4
           @args.delete_at(3)
        else
          "R1"
        end
      end

      def send_command
        if @command == :map && @args_size == 1
          @response = @board.send(@command)
        else
          @response = @robot.send(@command, *@args)
        end
      end

      def define_extended_rules
        @permitted_commands[:place][:args_size] = (3..4)
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
        @usage = define_usage
      end

      def valid_arg_size?
        @args_size = @args.size
        args_size = @properties[:args_size]
        if args_size.is_a?(Range)
          args_size.member?(@args_size)
        else
          args_size == @args_size
        end
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

      def define_usage
        "*** EXTENDED MODE ***\n"\
        "Valid Commands:\n"\
        "PLACE X,Y,F [ROBOT_NAME] eg: PLACE 0,0,NORTH KRYTEN\n"\
        "MOVE\n"\
        "LEFT\n"\
        "RIGHT\n"\
        "REPORT\n"\
        "SPIN\n"\
        "BLOCK\n"\
        "MAP [BOARD]\n"\
        "HELP\n"\
        "EXIT\n"\
        "-------\n"
      end
  end
end
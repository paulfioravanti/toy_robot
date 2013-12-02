require 'robot'
require 'board'
require 'command_set'
require 'usage'

module ToyRobot
  # Main application class for standard Toy Robot app
  class Application

    attr_reader   :board, :robot, :permitted_commands, :usage
    attr_accessor :command, :args

    def initialize
      @board = Board.new
      @robot = Robot.new(board)
      @permitted_commands = CommandSet.new
      @usage = Usage.message
    end

    def route(instruction)
      parse(instruction)
      if valid_command?
        robot.send(command, *args)
      else
        instruction.clear
      end
    end

    private

    def parse(instruction)
      extract_args_from(instruction)
      extract_command_from_args
    end

    def extract_args_from(instruction)
      @args = instruction.scan(%r{-?\w+})
    end

    def extract_command_from_args
      first_arg = args.shift
      @command = first_arg.downcase.to_sym if first_arg
    end

    def valid_command?
      permitted_command? &&
      valid_arg_size? &&
      passes_conditions?
    end

    def permitted_command?
      permitted_commands.contains?(command)
    end

    def valid_arg_size?
      permitted_commands.args_size_for(command) == args.size
    end

    def passes_conditions?
      conditions = permitted_commands.conditions_for(command)
      conditions.all? { |condition| send(condition) }
    end

    def coordinates_numerical?
      args[0..1].all? { |coordinate| coordinate.to_s.match(%r{[-?\d+]}) }
    end

    def valid_cardinal?
      %w(NORTH EAST SOUTH WEST).include?(args[2].upcase)
    end

    def placed?
      robot.position
    end
  end
end
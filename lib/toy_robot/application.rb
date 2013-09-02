require 'robot'
require 'board'
require 'command_set'
require 'usage'

module ToyRobot
  # Main application class for standard Toy Robot app
  class Application
    # include ActiveModel::Validations

    attr_reader   :board, :robot, :permitted_commands, :usage
    attr_accessor :command, :args

    def initialize
      @board = Board.new
      @robot = Robot.new(board)
      @permitted_commands = CommandSet.new # TODO: Test this
      @usage = Usage.message
    end

    def route(instruction)
      parse_instruction(instruction)
      if valid_command?
        robot.send(command, *args)
      else
        instruction.clear
      end
    end

    private

    def parse_instruction(instruction)
      @args = instruction.scan(%r{-?\w+})
      if inputted_command = args.shift
        @command = inputted_command.downcase.to_sym
      end
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
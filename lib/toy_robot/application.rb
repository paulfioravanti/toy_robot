require 'robot'
require 'board'
require 'command_set'
require 'usage'

module ToyRobot
  # Main application class for standard Toy Robot app
  class Application
    include ActiveModel::Validations

    attr_reader   :board, :robot, :permitted_commands, :usage
    attr_accessor :command, :args, :properties

    def initialize
      @board = Board.new
      @robot = Robot.new(board)
      # @permitted_commands = define_permitted_commands # Refactor into class
      @permitted_commands = CommandSet.new
      # @usage = define_usage # Refactor into class
      @usage = Usage.new.output
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

    # def define_permitted_commands
    #   {
    #     place: {
    #       args_size: 3,
    #       conditions: ['coordinates_numerical?', 'valid_cardinal?']
    #     },
    #     move: {
    #       args_size: 0,
    #       conditions: ['placed?']
    #     },
    #     left: {
    #       args_size: 0,
    #       conditions: ['placed?']
    #     },
    #     right: {
    #       args_size: 0,
    #       conditions: ['placed?']
    #     },
    #     report: {
    #       args_size: 0,
    #       conditions: ['placed?']
    #     }
    #   }
    # end

    # def define_usage
    #   "Valid Commands:\n"\
    #   "PLACE X,Y,F eg: PLACE 0,0,NORTH\n"\
    #   "MOVE\n"\
    #   "LEFT\n"\
    #   "RIGHT\n"\
    #   "REPORT\n"\
    #   "EXIT\n"\
    #   "-------\n"
    # end

    def parse_instruction(instruction)
      @args = instruction.scan(/-?\w+/)
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
      # @properties = permitted_commands[command]
      # @properties = permitted_commands.send(command)
      permitted_commands.respond_to?(command)
    end

    def valid_arg_size?
      # properties[:args_size] == args.size
      permitted_commands.send(command)[:args_size] == args.size
    end

    def passes_conditions?
      # conditions = properties[:conditions]
      conditions = permitted_commands.send(command)[:conditions]
      conditions.each { |condition| return false unless send(condition) }
    end

    def coordinates_numerical?
      args[0..1].each { |arg| return false if arg.to_s.match(%r{[^-?\d+]}) }
    end

    def valid_cardinal?
      %w(NORTH EAST SOUTH WEST).include?(args[2].upcase)
    end

    def placed?
      robot.position ? true : false
    end
  end
end
require 'active_model'

require 'robot'
require 'board'

module ToyRobot
  # Main application class for standard Toy Robot app
  class Application
    include ActiveModel::Validations

    attr_reader   :board, :robot, :permitted_commands, :usage
    attr_accessor :command, :args, :properties

    validates :permitted_commands, presence: true
    validates :usage, presence: true

    def initialize
      @board = Board.new
      @robot = Robot.new(@board)
      define_rules
    end

    def route(instruction)
      parse_instruction(instruction)
      if valid_command?
        @robot.send(@command, *@args)
      else
        instruction.clear
      end
    end

    private

      def parse_instruction(instruction)
        @args = instruction.scan(/-?\w+/)
        command = @args.shift
        @command = command.downcase.to_sym if command
      end

      def valid_command?
        permitted_command? &&
        valid_arg_size? &&
        passes_conditions?
      end

      def permitted_command?
        @properties = @permitted_commands[@command]
      end

      def valid_arg_size?
        @properties[:args_size] == @args.size
      end

      def passes_conditions?
        conditions = @properties[:conditions]
        conditions.each do |condition|
          return false unless send(condition)
        end
        true
      end

      def coordinates_numerical?
        @args[0..1].each { |arg| return false if arg.to_s.match(/[^-?\d+]/) }
      end

      def valid_cardinal?
        %w(NORTH north EAST east SOUTH south WEST west).include?(@args[2])
      end

      def placed?
        @robot.position ? true : false
      end

      def define_rules
        @permitted_commands = {
          place: {
            args_size: 3,
            conditions: ['coordinates_numerical?', 'valid_cardinal?']
          },
          move: {
            args_size: 0,
            conditions: ['placed?']
          },
          left: {
            args_size: 0,
            conditions: ['placed?']
          },
          right: {
            args_size: 0,
            conditions: ['placed?']
          },
          report: {
            args_size: 0,
            conditions: ['placed?']
          }
        }
        @usage = define_usage
      end

      def define_usage
        "Valid Commands:\n"\
        "PLACE X,Y,F eg: PLACE 0,0,NORTH\n"\
        "MOVE\n"\
        "LEFT\n"\
        "RIGHT\n"\
        "REPORT\n"\
        "EXIT\n"\
        "-------\n"
      end
  end
end
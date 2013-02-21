require 'active_model'

require 'robot'

module ToyRobot
  # Main application class for standard Toy Robot app
  class Application
    include ActiveModel::Validations

    attr_reader   :board, :robot, :permitted_commands, :usage
    attr_accessor :command, :args

    validates :permitted_commands, presence: true
    validates :usage, presence: true

    def initialize
      define_rules
    end

    def route(instruction)
      execute_instruction(instruction)
    end

    private

      def execute_instruction(instruction)
        if parse_instruction(instruction) && valid_robot_command?
          initialize_world if @command == :place
          response = @robot.send(@command, *@args)
        else
          response = ""
        end
      end

      def initialize_world
        @board ||= Board.new
        @robot ||= Robot.new(@board)
      end

      def define_rules
        @permitted_commands = [
          {
            name: :place,
            args_size: 3,
            conditions: ['coordinates_numerical?', 'valid_cardinal?']
          },
          {
            name: :move,
            args_size: 0,
            conditions: ['placed?']
          },
          {
            name: :left,
            args_size: 0,
            conditions: ['placed?']
          },
          {
            name: :right,
            args_size: 0,
            conditions: ['placed?']
          },
          {
            name: :report,
            args_size: 0,
            conditions: ['placed?']
          }
        ]
        @usage = define_usage
      end

      def parse_instruction(instruction)
        @args = instruction.scan(/-?\w+/)
        command = @args.shift
        @command = command.downcase.to_sym if command
      end

      def valid_robot_command?
        robot_command = @permitted_commands.find do |command|
          command[:name] == @command &&
          command[:args_size] == @args.size
        end
        if robot_command
          robot_command[:conditions].each do |condition|
            return false unless send(condition)
          end
        else
          false
        end
      end

      def coordinates_numerical?
        @args[0..1].each { |arg| return false if arg.to_s.match(/[^-?\d+]/) }
      end

      def valid_cardinal?
        %w(NORTH north EAST east SOUTH south WEST west).include?(@args[2])
      end

      def placed?
        @robot && @robot.position ? true : false
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
require 'active_model'

require 'extended_board'
require 'extended_robot'
require 'application_map'

module ToyRobot
  # Main application class for extended Toy Robot app
  class ExtendedApplication < Application

    attr_accessor :response, :target_name, :robots, :app_map

    validates :board, presence: true

    def initialize
      super
      @robots = []
      @board = ExtendedBoard.new
      define_extended_rules
    end

    def route(instruction)
      return "" if instruction.rstrip.empty?
      execute_instruction(instruction)
      process_response
    end

    private

      def execute_instruction(instruction)
        parse_instruction(instruction)
        if valid_command?
          find_or_create_robot if @command == :place
          send_command
        else
          @response = ""
        end
      end

      def parse_instruction(instruction)
        return false unless super(instruction)
        if @args.empty?
          determine_target
        else
          assign_target
        end
      end

      def determine_target
        if @command == :map
          @target_name = "APP"
        elsif @robots.size == 1 && @command != :place
          @target_name = @robots.first.name
        else
          @target_name = nil
        end
      end

      def assign_target
        case @args.size
        when 1, 4
          @target_name = @args.pop
        when 3
          @target_name = "R#{@robots.size + 1}"
        end
      end

      def placed?
        robot = find_robot
        robot && robot.position ? true : false
      end

      def valid_map_target?
        robot = find_robot
        if robot || @target_name =~ /BOARD/i || @target_name == "APP"
          true
        else
          false
        end
      end

      def find_or_create_robot
        robot = find_robot
        @robots << ExtendedRobot.new(@board, @target_name) unless robot
      end

      def send_command
        if robot = find_robot
          @response = robot.send(@command, *@args)
          @robots.delete(robot) if !placed?
        else
          if @command == :map
            if @target_name =~ /BOARD/i
              @response = @board.map
            elsif @target_name == "APP"
              @response = map
            end
          end
        end
      end

      def find_robot
        @robots.find { |robot| robot.name =~ /^#{@target_name}$/i }
      end

      def map
        @app_map = "#{ApplicationMap.new(self).output}"\
                  "Robots on the Board:\n"
        if @robots.empty?
          @app_map << "None\n"
        else
          add_robot_info_to_map
        end
        @app_map
      end

      def add_robot_info_to_map
        @robots.each do |robot|
          @app_map << "Name: #{robot.name}\n#{robot.report}"
          unless robot.blocks.empty?
            @app_map << "#{robot.report_block_positions}"
          end
          @app_map << "-------\n"
        end
      end

      def process_response
        @response << "Invalid Command.\n" if @response.empty?
        if @robots.empty?
          @response << "Hint: PLACE a robot first.\n"
        elsif !@target_name
          @response << "Specify which robot to perform action.\n"
        end
        @response
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
            args_size: 0,
            conditions: ['valid_map_target?']
          }
        })
        @usage = define_usage
      end

      def define_usage
        "*** EXTENDED MODE ***\n"\
        "Valid Commands:\n"\
        "New Robot: PLACE X,Y,F [<ROBOT_NAME>]\n"\
        "Re-place Robot: PLACE X,Y,F <ROBOT_NAME>\n"\
        "MOVE [<ROBOT_NAME>]\n"\
        "LEFT [<ROBOT_NAME>]\n"\
        "RIGHT [<ROBOT_NAME>]\n"\
        "REPORT [<ROBOT_NAME>]\n"\
        "SPIN [<ROBOT_NAME>]\n"\
        "BLOCK [<ROBOT_NAME>]\n"\
        "MAP [<ROBOT_NAME>] [BOARD]\n"\
        "HELP\n"\
        "EXIT\n"\
        "-------\n"
      end
  end
end
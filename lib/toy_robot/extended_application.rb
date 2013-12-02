require 'active_model'

require 'extended_board'
require 'extended_robot'
require 'extended_command_set'
require 'extended_usage'
require 'application_map'
require 'colorable'

module ToyRobot
  # Main application class for extended Toy Robot app
  class ExtendedApplication < Application
    include Colorable

    attr_accessor :response, :target_name, :robots, :app_map

    def initialize
      @robots = []
      @board = ExtendedBoard.new
      @permitted_commands = ExtendedCommandSet.new
      @usage = ExtendedUsage.message
    end

    def route(instruction)
      return "" if instruction.rstrip.empty?
      execute_instruction(instruction)
      process_response
    end

    private

      def execute_instruction(instruction)
        parse(instruction)
        if valid_command?
          find_or_create_robot if @command == :place
          send_command
        else
          @response = ""
        end
      end

      def parse(instruction)
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
        robot = find_robot || ExtendedRobot.new(@board, @target_name)
        @robots << robot unless robot.position
      end

      def send_command
        if robot = find_robot
          @response = robot.send(@command, *@args)
          @robots.delete(robot) if !placed?
        else
          if @target_name =~ /BOARD/i
            @response = @board.map
          elsif @target_name == "APP"
            @response = map
          end
        end
      end

      def find_robot
        @robots.find { |robot| robot.name =~ /^#{@target_name}$/i }
      end

      def map
        @app_map = "#{ApplicationMap.new(self).output}"\
                  "#{magenta "Robots on the Board:"}\n"
        if @robots.empty?
          @app_map << cyan("None\n")
        else
          add_robot_info_to_map
        end
        @app_map
      end

      def add_robot_info_to_map
        @robots.each do |robot|
          @app_map << yellow("Name: #{robot.name}\n#{robot.report}")
          unless robot.blocks.empty?
            @app_map << yellow("#{robot.report_block_positions}")
          end
          @app_map << "-------\n"
        end
      end

      def process_response
        @response << red("Invalid Command.\n") if @response.empty?
        if @robots.empty?
          @response << yellow("Hint: PLACE a robot first.\n")
        elsif !@target_name
          @response << yellow("Specify which robot to perform action.\n")
        end
        @response
      end

      # def define_extended_rules
      #   @usage = define_usage
      # end

      # def define_usage
      #   "#{bold_green "*** EXTENDED MODE ***"}\n"\
      #   "#{yellow "Valid Commands:"}\n"\
      #   "#{cyan "New Robot"}:\n"\
      #   "  PLACE X,Y,F [<ROBOT_NAME>]\n"\
      #   "#{cyan "Re-place Robot"}:\n"\
      #   "  PLACE X,Y,F <ROBOT_NAME>\n"\
      #   "MOVE [<ROBOT_NAME>]\n"\
      #   "LEFT [<ROBOT_NAME>]\n"\
      #   "RIGHT [<ROBOT_NAME>]\n"\
      #   "REPORT [<ROBOT_NAME>]\n"\
      #   "SPIN [<ROBOT_NAME>]\n"\
      #   "BLOCK [<ROBOT_NAME>]\n"\
      #   "MAP [<ROBOT_NAME>] [BOARD]\n"\
      #   "HELP\n"\
      #   "EXIT\n"\
      #   "-------\n"
      # end
  end
end
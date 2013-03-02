require 'active_model'

require 'extended_board'
require 'extended_robot'
require 'application_map'

module ToyRobot
  # Main application class for extended Toy Robot app
  class ExtendedApplication < Application

    attr_accessor :response, :target_name, :robots

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
        if parse_instruction(instruction) && valid_robot_command?
          add_robot_to_board if @command == :place
          send_command
        else
          @response = ""
        end
      end

      def parse_instruction(instruction)
        return false unless super(instruction)
        if @args.size == 1 || @args.size == 4
          @target_name = @args.pop
        elsif @args.empty? && @command == :map
          @target_name = "APP"
        elsif @args.empty? && @robots.size == 1 && @command != :place
          @target_name = @robots.first.name
        elsif @args.size == 3
          @target_name = "R#{@robots.size + 1}"
        else
          @target_name = nil
          false
        end
      end

      def placed?
        return true if @target_name =~ /BOARD/i || @target_name == "APP"
        robot = @robots.find { |robot| robot.name =~ /^#{@target_name}$/i }
        robot && robot.position ? true : false
      end

      def valid_map_target?
        robot = @robots.find { |robot| robot.name =~ /^#{@target_name}$/i }
        if robot || @target_name =~ /BOARD/i || @target_name == "APP"
          true
        else
          false
        end
      end

      def add_robot_to_board
        robot = @robots.find { |robot| robot.name =~ /^#{@target_name}$/i }
        @robots << ExtendedRobot.new(@board, @target_name) unless robot
      end

      def send_command
        if @command == :map && @target_name =~ /BOARD/i
          @response = @board.map
        elsif @command == :map && @target_name == "APP"
          @response = map
        else
          robot = @robots.find { |robot| robot.name =~ /^#{@target_name}$/i }
          @response = robot.send(@command, *@args) if robot
          @robots.delete(robot) if !placed?
        end
      end

      def map
        app_map = "#{ApplicationMap.new(self).output}"\
                  "Robots on the Board:\n"
        if @robots.empty?
          app_map << "None\n"
        else
          @robots.each do |robot|
            app_map << "Name: #{robot.name}\n"
            app_map << "#{robot.report}"
            unless robot.blocks.empty?
              app_map << "#{robot.report_block_positions}"
            end
            app_map << "-------\n"
          end
        end
        app_map
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
            conditions: ['placed?', 'valid_map_target?']
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
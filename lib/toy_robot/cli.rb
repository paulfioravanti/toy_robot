require 'thor'

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "toy_robot")
require 'board'
require 'robot'

module ToyRobot
  # Command line interface for the toy Robot
  class CLI < Thor

    attr_accessor :robot, :command, :args, :response

    method_option :filename, aliases: ['-f'],
                  desc: "name of the file containing robot instructions",
                  banner: 'FILE'
    desc "execute robot commands", "moves robot on a board as per commands"
    def execute
      @robot = Robot.new
      instructions do |instruction|
        parse_instruction(instruction)
        if valid_robot_command?
          @response = @robot.send(@command, *@args)
          output_response if @response
        end
      end
    end

    default_task :execute

    no_tasks do
      def instructions
        if file = options[:filename]
          File.readlines(file).map do |line|
            yield line.strip.chomp
          end
        else
          print usage
          while line = gets
            break if line =~ /EXIT/i
            yield line
            print "> "
          end
        end
      end

      def parse_instruction(instruction)
        @args = instruction.scan(/-?\w+/)
        command = @args.shift
        @command = command.downcase.to_sym if command
      end

      def output_response
        if [:report, :map].include?(@command)
          puts @response
        end
        @command = nil
      end

      def valid_robot_command?
        valid_place_command? || valid_singular_command?
      end

      def valid_place_command?
        @command == :place &&
        @args.size == 3 &&
        coordinates_numerical? &&
        valid_cardinal?
      end

      def valid_singular_command?
        [:move, :left, :right, :report, :place_block, :map].include?(@command) &&
        @args.size == 0
      end

      def coordinates_numerical?
        @args[0..1].each { |arg| return false if arg.to_s.match(/[^-?\d+]/) }
      end

      def valid_cardinal?
        %w(NORTH north EAST east SOUTH south WEST west).include?(@args[2])
      end

      def usage
        usage = usage_header
        usage << usage_standard
        usage << usage_extended
        usage << usage_footer
      end

      def usage_header
        "Valid Commands:\n"
      end

      def usage_standard
        "PLACE X,Y,F eg: PLACE 0,0,NORTH\n"\
        "MOVE\n"\
        "LEFT\n"\
        "RIGHT\n"\
        "REPORT\n"
      end

      def usage_extended
        "PLACE_BLOCK\n"\
        "MAP\n"
      end

      def usage_footer
        "EXIT\n"\
        "-------\n"\
        "> "
      end
    end
  end
end
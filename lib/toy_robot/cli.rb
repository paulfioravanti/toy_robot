require 'thor'
require 'toy_robot/board'
require 'toy_robot/robot'

module ToyRobot
  # Command line interface for the toy Robot
  class CLI < Thor

    attr_accessor :robot, :command, :args, :output

    method_option :filename, aliases: ['-f'],
                  desc: "name of the file containing robot instructions",
                  banner: 'FILE'

    desc "execute robot commands", "moves robot on a board as per commands"
    def execute
      @robot = Robot.new
      instructions do |instruction|
        @args = instruction.scan(/-?\w+/)
        @command = @args.shift.downcase.to_sym
        if valid_robot_command? &&
          @output = @robot.send(@command, *@args)
          puts formatted_output
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

      def formatted_output
        "#{@output[:x_position]},"\
        "#{@output[:y_position]},"\
        "#{@output[:cardinal_direction]}"
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
        [:move, :left, :right, :report].include?(@command) &&
        @args.size == 0 &&
        @robot.placed
      end

      def coordinates_numerical?
        @args[0..1].each { |arg| return false if arg.to_s.match(/[^-?\d+]/) }
      end

      def valid_cardinal?
        %w(NORTH north EAST east SOUTH south WEST west).include?(@args[2])
      end

      def usage
        "Valid Commands:\n"\
        "PLACE X,Y,F eg: PLACE 0,0,NORTH\n"\
        "MOVE\n"\
        "LEFT\n"\
        "RIGHT\n"\
        "REPORT\n"\
        "EXIT\n"\
        "-------\n"\
        "> "
      end
    end
  end
end
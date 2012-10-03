require 'thor'
require 'toy_robot/board'
require 'toy_robot/robot'

module ToyRobot
  class CLI < Thor

    method_option :filename, aliases: ['-f'],
                  desc: "name of the file containing robot instructions",
                  banner: 'FILE'

    desc "execute robot commands", "moves robot on a board as per commands"
    def execute
      board = Board.new(left_boundary: 0, right_boundary: 4,
                        top_boundary: 4, bottom_boundary: 0)
      robot = Robot.new(board: board, placed: false)
      instruction_set do |instructions|
        instructions.each do |instruction|
          command, args = parse_instruction(instruction)
          if valid_robot_command?(command, args)
            response = robot.send(command, *args)
            puts format(response) if response
          end
        end
      end
    end

    default_task :execute

    no_tasks do
      def instruction_set
        if options[:filename]
          yield File.readlines(options[:filename]).map { |a| a.strip.chomp }
        else
          puts usage
          print "> "
          while line = gets
            break if line =~ /EXIT/i
            yield [line]
            print "> "
          end
        end
      end

      def format(output)
        "#{output[:x_position]},"\
        "#{output[:y_position]},"\
        "#{output[:cardinal_direction]}"
      end

      def parse_instruction(instruction)
        args = instruction.scan(/-?\w+/)
        command = args.shift.downcase.to_sym
        [command, args]
      end

      def valid_robot_command?(command, args)
        [:place, :move, :left, :right, :report].include?(command) &&
        (args.size == 0 || (args.size == 3 if command == :place))
      end

      def usage
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
end
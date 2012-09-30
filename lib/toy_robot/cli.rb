require 'thor'
require 'toy_robot/board'
require 'toy_robot/robot'

module ToyRobot
  class CLI < Thor

    attr_writer :instructions

    class_option :filename, aliases: ['-f'],
                 default: 'instructions.txt',
                 desc: "name of the file containing robot instructions",
                 banner: 'FILE'

    desc "execute commands in FILE", "moves robot on a board as per commands"
    def execute
      board = Board.new(left_boundary: 0, right_boundary: 4,
                        top_boundary: 4, bottom_boundary: 0)
      robot = Robot.new(board: board)
      instructions.each do |instruction|
        command, args = parse_instruction(instruction)
        if valid_robot_command?(command, args)
          response = robot.send(command, *args)
          # p response
          # if command == :report #&& robot.valid?
          puts format(response) unless response.nil?
          # else
            # puts robot.errors.full_messages if robot.errors.any?
          # end
        # else
          # puts %Q{"#{instruction}" command incorrect or not recognised}
        end
      end
    end

    default_task :execute

    no_tasks do
      def instructions
        @instructions ||=
          File.readlines(options[:filename]).map { |a| a.chomp }
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
    end
  end
end
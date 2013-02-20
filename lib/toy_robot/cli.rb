require 'thor'

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "toy_robot")
require 'application'

module ToyRobot
  # Command line interface for the toy Robot
  class CLI < Thor

    attr_accessor :application

    method_option :file, type: :string, aliases: '-f',
                  desc: "name of the file containing robot instructions",
                  banner: 'FILE'
    method_option :extended, type: :boolean, aliases: '-e',
                  desc: "flag for extended mode"
    desc "execute robot commands", "moves robot on a board as per commands"
    def execute
      @application = unless options[:extended]
        Application.new
      else
        ExtendedApplication.new
      end
      instructions do |instruction|
        response = @application.route(instruction)
        print response if response.is_a?(String)
      end
    end

    default_task :execute

    no_tasks do
      def instructions(&instruction)
        if filename = options[:file]
          read_from_file(filename, &instruction)
        else
          read_from_command_line(&instruction)
        end
      end

      def read_from_file(filename, &instruction)
        begin
          File.readlines(filename).map do |line|
            yield line.strip.chomp
          end
        rescue
          puts "Filename not specified or does not exist."
        end
      end

      def read_from_command_line(&instruction)
        print "#{@application.usage}> "
        ARGV.delete('-e')
        while line = gets
          break if line =~ /EXIT/i
          yield line
          print "> "
        end
      end
    end
  end
end
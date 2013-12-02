module ToyRobot
  class CommandSet
    attr_reader :commands

    def initialize
      @commands = {
        place: {
          args_size: 3,
          conditions: ['coordinates_numerical?', 'valid_cardinal?']
        },
        move: {
          args_size: 0,
          conditions: ['placed?']
        }
      }
      @commands.merge!(
        {
          left: @commands[:move],
          right: @commands[:move],
          report: @commands[:move]
        }
      )
    end

    def contains?(command)
      commands.has_key?(command)
    end

    def args_size_for(command)
      commands[command][:args_size]
    end

    def conditions_for(command)
      commands[command][:conditions]
    end
  end
end
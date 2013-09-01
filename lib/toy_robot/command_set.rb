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
        },
        left: {
          alias_to: :move
        },
        right: {
          alias_to: :move
        },
        report: {
          alias_to: :move
        }
      }
    end

    def contains?(command)
      commands.has_key?(command)
    end

    def args_size_for(command)
      command = parse(command)
      commands[command][:args_size]
    end

    def conditions_for(command)
      command = parse(command)
      commands[command][:conditions]
    end

    private

    def parse(command)
      commands[command][:alias_to] || command
    end
  end
end
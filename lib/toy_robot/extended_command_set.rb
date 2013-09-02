module ToyRobot
  class ExtendedCommandSet < CommandSet
    # attr_reader :commands

    def initialize
      super
      @commands = commands.merge({
        spin: {
          alias_to: :move
        },
        block: {
          alias_to: :move
        },
        map: {
          args_size: 0,
          conditions: ['valid_map_target?']
        }
      })
    end

    # def contains?(command)
    #   commands.has_key?(command)
    # end

    # def args_size_for(command)
    #   command = parse(command)
    #   commands[command][:args_size]
    # end

    # def conditions_for(command)
    #   command = parse(command)
    #   commands[command][:conditions]
    # end

    # private

    # def parse(command)
    #   commands[command][:alias_to] || command
    # end
  end
end
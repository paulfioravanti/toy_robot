module ToyRobot
  class ExtendedCommandSet < CommandSet
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
  end
end
module ToyRobot
  class ExtendedCommandSet < CommandSet
    def initialize
      super
      @commands.merge!(
        {
          spin: @commands[:move],
          block: @commands[:move],
          map: {
            args_size: 0,
            conditions: ['valid_map_target?']
          }
        }
      )
    end
  end
end
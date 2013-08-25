module ToyRobot
  class CommandSet
    def place
      {
        args_size: 3,
        conditions: ['coordinates_numerical?', 'valid_cardinal?']
      }
    end

    def move
      {
        args_size: 0,
        conditions: ['placed?']
      }
    end

    alias_method :left, :move
    alias_method :right, :move
    alias_method :report, :move
  end
end
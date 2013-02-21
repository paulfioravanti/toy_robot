def boundaries
  [
    :@left_boundary,
    :@right_boundary,
    :@top_boundary,
    :@bottom_boundary
  ]
end

def position_values
  [ :@x_coordinate, :@y_coordinate ]
end

def valid_cardinals
  %w(NORTH EAST SOUTH WEST)
end

def non_place_instructions
  ["MOVE", "LEFT", "RIGHT", "REPORT"]
end

def permitted_commands
  [
    {
      name: :place,
      args_size: 3,
      conditions: ['coordinates_numerical?', 'valid_cardinal?']
    },
    {
      name: :move,
      args_size: 0,
      conditions: ['placed?']
    },
    {
      name: :left,
      args_size: 0,
      conditions: ['placed?']
    },
    {
      name: :right,
      args_size: 0,
      conditions: ['placed?']
    },
    {
      name: :report,
      args_size: 0,
      conditions: ['placed?']
    }
  ]
end

def extended_permitted_commands
  [
    {
      name: :place,
      args_size: 3,
      conditions: ['coordinates_numerical?', 'valid_cardinal?']
    },
    {
      name: :move,
      args_size: 0,
      conditions: ['placed?']
    },
    {
      name: :left,
      args_size: 0,
      conditions: ['placed?']
    },
    {
      name: :right,
      args_size: 0,
      conditions: ['placed?']
    },
    {
      name: :report,
      args_size: 0,
      conditions: ['placed?']
    },

    {
      name: :block,
      args_size: 0,
      conditions: ['placed?']
    },
    {
      name: :map,
      args_size: 0,
      conditions: ['placed?']
    }
  ]
end
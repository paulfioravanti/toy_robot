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
  {
    place: {
      args_size: 3,
      conditions: ['coordinates_numerical?', 'valid_cardinal?']
    },
    move: {
      args_size: 0,
      conditions: ['placed?']
    },
    left: {
      args_size: 0,
      conditions: ['placed?']
    },
    right: {
      args_size: 0,
      conditions: ['placed?']
    },
    report: {
      args_size: 0,
      conditions: ['placed?']
    }
  }
end

def extended_permitted_commands
  {
    place: {
      args_size: 3,
      conditions: ['coordinates_numerical?', 'valid_cardinal?']
    },
    move: {
      args_size: 0,
      conditions: ['placed?']
    },
    left: {
      args_size: 0,
      conditions: ['placed?']
    },
    right: {
      args_size: 0,
      conditions: ['placed?']
    },
    report: {
      args_size: 0,
      conditions: ['placed?']
    },
    spin: {
      args_size: 0,
      conditions: ['placed?']
    },
    block: {
      args_size: 0,
      conditions: ['placed?']
    },
    map: {
      args_size: (0..1),
      conditions: ['placed?', 'valid_map_type?']
    }
  }
end

# In relation to Position.new(2, 3)
def lesser_positions
  [
    Position.new(1, 2),
    Position.new(1, 3),
    Position.new(1, 4),
    Position.new(2, 1)
  ]
end

# In relation to Position.new(2, 3)
def greater_positions
  [
    Position.new(2, 4),
    Position.new(3, 1),
    Position.new(3, 3),
    Position.new(3, 4)
  ]
end
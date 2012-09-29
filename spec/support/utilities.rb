def valid_cardinal_directions
  %w(NORTH EAST SOUTH WEST)
end

def boundary_variables
  [
    :@left_boundary,
    :@right_boundary,
    :@top_boundary,
    :@bottom_boundary
  ]
end

def coordinate_values
  [
    :@x_position,
    :@y_position
  ]
end

def test_data
  [
    {
      input: "PLACE 0,0,NORTH\r
              MOVE\r
              REPORT",
      output: "0,1,NORTH"
    },

    {
      input: "PLACE 0,0,NORTH\r
              LEFT\r
              REPORT",
      output: "0,0,WEST"
    },

    {
      input: "PLACE 1,2,EAST\r
              MOVE\r
              MOVE\r
              LEFT\r
              MOVE\r
              REPORT",
      output: "3,3,NORTH"
    }
  ]
end
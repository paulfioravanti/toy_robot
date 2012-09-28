def valid_directions
  %w(NORTH EAST SOUTH WEST)
end

def boundary_variables
  [
    :@left_boundary_x,
    :@right_boundary_x,
    :@top_boundary_y,
    :@bottom_boundary_y
  ]
end

def coordinate_values
  [
    :@current_x,
    :@current_y
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
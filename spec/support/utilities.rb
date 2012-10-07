def valid_cardinals
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

def valid_test_data
  [
    { # Provided example 1
      input: "PLACE 0,0,NORTH\r
              MOVE\r
              REPORT",
      output: "0,1,NORTH\n"
    },

    { # Provided example 2
      input: "PLACE 0,0,NORTH\r
              LEFT\r
              REPORT",
      output: "0,0,WEST\n"
    },

    { # Provided example 3
      input: "PLACE 1,2,EAST\r
              MOVE\r
              MOVE\r
              LEFT\r
              MOVE\r
              REPORT",
      output: "3,3,NORTH\n"
    },

    { # Commands before placing
      input: "MOVE\r
              MOVE\r
              LEFT\r
              MOVE\r
              PLACE 1,2,EAST\r
              MOVE\r
              REPORT",
      output: "2,2,EAST\n"
    },

    { # Multiple placings
      input: "PLACE 1,2,EAST\r
              PLACE 0,0,NORTH\r
              PLACE 4,4,WEST\r
              REPORT",
      output: "4,4,WEST\n"
    },

    { # Attempting to go out of bounds
      input: "PLACE 0,0,WEST\r
              MOVE\r
              LEFT\r
              MOVE\r
              PLACE 4,4,NORTH\r
              MOVE\r
              RIGHT\r
              MOVE\r
              REPORT",
      output: "4,4,EAST\n"
    },

    { # Multiple calls to report
      input: "PLACE 0,0,WEST\r
              REPORT\r
              PLACE 4,4,NORTH\r
              REPORT",
      output: "0,0,WEST\n"\
              "4,4,NORTH\n"
    }
  ]
end

def invalid_test_data
  [
     { # Invalid commands, bad placing arguments, placing off board
       input: "INVALID\r
               FRAGGLE\r
               PLACE A,0,NORTH\r
               PLACE 0,B,NORTH\r
               PLACE 0,0,DEATHSTAR\r
               PLACE 5,5,SOUTH\r
               PLACE -2,-2,WEST\r
               REPORT",
       output: ""
     }
  ]
end

def usage
  "Valid Commands:\n"\
  "PLACE X,Y,F eg: PLACE 0,0,NORTH\n"\
  "MOVE\n"\
  "LEFT\n"\
  "RIGHT\n"\
  "REPORT\n"\
  "EXIT\n"\
  "-------\n"
end

def prompt
  "> "
end
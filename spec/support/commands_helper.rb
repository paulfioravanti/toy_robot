def valid_test_commands
  [
    { # Provided example 1
      input: "PLACE 0,0,NORTH\r
              MOVE\r
              REPORT",
      output: ["0,1,NORTH\n"]
    },

    { # Provided example 2
      input: "PLACE 0,0,NORTH\r
              LEFT\r
              REPORT",
      output: ["0,0,WEST\n"]
    },

    { # Provided example 3
      input: "PLACE 1,2,EAST\r
              MOVE\r
              MOVE\r
              LEFT\r
              MOVE\r
              REPORT",
      output: ["3,3,NORTH\n"]
    },

    { # Commands before placing
      input: "MOVE\r
              MOVE\r
              LEFT\r
              RIGHT\r
              MOVE\r
              PLACE 1,2,EAST\r
              MOVE\r
              REPORT",
      output: ["2,2,EAST\n"]
    },

    { # Multiple placings
      input: "PLACE 1,2,EAST\r
              PLACE 0,0,NORTH\r
              PLACE 4,4,WEST\r
              REPORT",
      output: ["4,4,WEST\n"]
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
      output: ["4,4,EAST\n"]
    },

    { # Multiple calls to report
      input: "PLACE 0,0,WEST\r
              REPORT\r
              PLACE 4,4,NORTH\r
              REPORT",
      output: ["0,0,WEST\n", "4,4,NORTH\n"]
    },

    { # Extended commands are ignored;
      input: "PLACE 0,0,NORTH\r
              MOVE\r
              BLOCK\r
              MOVE\r
              MAP\r
              REPORT",
      output: ["0,2,NORTH\n"]
    }
  ]
end

def extended_valid_test_commands
  [
    { # Output a map
      input: "PLACE 2,2,NORTH\r
              MAP",
      output: ["Robot placed at: 2,2,NORTH\n", "#{robot_2_2_north_map}"]
    },

    { # Blocked by blocks, can't progress;
      # attempt place on top of block and fail
      input: "PLACE 0,0,NORTH\r
              MOVE\r
              BLOCK\r
              MOVE\r
              PLACE 0,2,NORTH\r
              REPORT",
      output: [
                 "Robot placed at: 0,0,NORTH\n",
                 "Robot moved forward to 0,1,NORTH\n",
                 "Block placed at 0,2\n",
                 "Robot cannot move to 0,2\n",
                 "Robot cannot be placed at: 0,2\n",
                 "Robot Position: 0,1,NORTH\n"
              ]
    },
  ]
end

def invalid_test_commands
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
      output: [""]
    },

    { # No commands, just a return carriage
      input: "\r",
      output: [""]
    }
  ]
end

def extended_invalid_test_commands
  [
    { # Invalid commands, bad placing arguments, placing off board
      input: "INVALID\r
              FRAGGLE\r
              PLACE A,0,NORTH\r
              PLACE 2,2,NORTH\r
              PLACE 0,B,NORTH\r
              PLACE 0,0,DEATHSTAR\r
              PLACE 5,5,SOUTH\r
              PLACE -2,-2,WEST\r
              REPORT\r",
      output: [
                "Invalid Command.\nHint: PLACE robot first.\n",
                "Invalid Command.\nHint: PLACE robot first.\n",
                "Invalid Command.\nHint: PLACE robot first.\n",
                "Robot placed at: 2,2,NORTH\n",
                "Invalid Command.\n",
                "Invalid Command.\n",
                "Robot cannot be placed at: 5,5\n",
                "Robot cannot be placed at: -2,-2\n",
                "Robot Position: 2,2,NORTH\n"
              ]
    },

    { # No commands, just a return carriage
      input: "\n",
      output: [""]
    }
  ]
end
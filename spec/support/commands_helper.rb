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
    { # Output a map without blocks
      input: "PLACE 2,2,NORTH\r
              MAP",
      output: ["Robot R1 placed at: 2,2,NORTH\n", "#{robot_2_2_north_map}"]
    },

    { # Output a map with three blocks
      input: "PLACE 2,2,NORTH\r
              BLOCK\r
              RIGHT\r
              BLOCK\r
              RIGHT\r
              BLOCK\r
              RIGHT\r
              BLOCK\r
              MAP\r
              MAP BOARD",
      output: [
                "Robot R1 placed at: 2,2,NORTH\n",
                "R1 placed Block at: 2,3\n",
                "R1 turned right. Current direction: EAST\n",
                "R1 placed Block at: 3,2\n",
                "R1 turned right. Current direction: SOUTH\n",
                "R1 placed Block at: 2,1\n",
                "R1 turned right. Current direction: WEST\n",
                "R1 placed Block at: 1,2\n",
                "#{robot_2_2_west_map_with_4_blocks}",
                "#{robot_2_2_west_board_map_with_4_blocks}"
              ]
    },

    { # Output a map full of blocks
      input: "PLACE 2,2,NORTH\r
              MAP",
      output: ["Robot R1 placed at: 2,2,NORTH\n", "#{robot_2_2_north_map}"]
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
                "Robot R1 placed at: 0,0,NORTH\n",
                "R1 moved forward to 0,1,NORTH\n",
                "R1 placed Block at: 0,2\n",
                "R1 cannot move to 0,2\n",
                "Robot R1 cannot be placed at: 0,2\n",
                "R1's Position: 0,1,NORTH\n"
              ]
    },

    { # Turn 180 degrees
      input: "PLACE 2,2,NORTH\r
              SPIN\r
              REPORT",
      output: [
                "Robot R1 placed at: 2,2,NORTH\n",
                "R1 spun around. Current direction: SOUTH\n",
                "R1's Position: 2,2,SOUTH\n"
              ]
    }
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
                "Robot R1 placed at: 2,2,NORTH\n",
                "Invalid Command.\n",
                "Invalid Command.\n",
                "Robot R1 cannot be placed at: 5,5\n",
                "Robot R1 cannot be placed at: -2,-2\n",
                "R1's Position: 2,2,NORTH\n"
              ]
    },

    { # No commands, just a return carriage
      input: "\n",
      output: [""]
    }
  ]
end
def empty_board_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [ ] [ ]\n"\
  "2 [ ] [ ] [ ] [ ] [ ]\n"\
  "1 [ ] [ ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "Occupied Positions:\n"\
  "None\n"\
  "Hint: PLACE a robot first.\n"
end

def one_robot_r1_board_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [ ] [ ]\n"\
  "2 [ ] [ ] [X] [ ] [ ]\n"\
  "1 [ ] [ ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "Occupied Positions:\n"\
  "[2, 2]\n"
end

def one_robot_r1_with_blocks_board_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [X] [ ] [ ]\n"\
  "2 [ ] [X] [X] [X] [ ]\n"\
  "1 [ ] [ ] [X] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "Occupied Positions:\n"\
  "[1, 2], [2, 1], [2, 2],\n"\
  "[2, 3], [3, 2]\n"
end

def two_robots_board_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [X] [ ]\n"\
  "2 [ ] [ ] [ ] [ ] [ ]\n"\
  "1 [ ] [X] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "Occupied Positions:\n"\
  "[1, 1], [3, 3]\n"
end

def two_robots_with_blocks_board_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [X] [ ]\n"\
  "3 [ ] [ ] [X] [X] [X]\n"\
  "2 [ ] [X] [ ] [X] [ ]\n"\
  "1 [X] [X] [X] [ ] [ ]\n"\
  "0 [ ] [X] [ ] [ ] [ ]\n"\
  "Occupied Positions:\n"\
  "[0, 1], [1, 0], [1, 1],\n"\
  "[1, 2], [2, 1], [2, 3],\n"\
  "[3, 2], [3, 3], [3, 4],\n"\
  "[4, 3]\n"
end

def robot_2_2_north_with_block_board_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [X] [ ] [ ]\n"\
  "2 [ ] [ ] [X] [ ] [ ]\n"\
  "1 [ ] [ ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "Occupied Positions:\n"\
  "[2, 2], [2, 3]\n"
end

def one_robot_board_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [ ] [ ]\n"\
  "2 [ ] [ ] [X] [ ] [ ]\n"\
  "1 [ ] [ ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"
end

def robot_and_blocks_board_map
  "   0   1   2   3   4\n"\
  "4 [ ] [X] [ ] [X] [ ]\n"\
  "3 [X] [ ] [X] [ ] [X]\n"\
  "2 [ ] [X] [ ] [X] [ ]\n"\
  "1 [X] [ ] [X] [ ] [X]\n"\
  "0 [ ] [X] [ ] [X] [X]\n"
end
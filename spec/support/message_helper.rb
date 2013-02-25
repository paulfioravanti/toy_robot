# encoding: UTF-8

def pre_place_invalid_response
  "Invalid Command.\nHint: PLACE robot first.\n"
end

def post_place_invalid_response
  "Invalid Command.\n"
end

def robot_2_2_north_report
  "2,2,NORTH\n"
end

def extended_robot_2_2_north_report
  "Robot Position: 2,2,NORTH\n"
end

def robot_2_2_north_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [ ] [ ]\n"\
  "2 [ ] [ ] [Λ] [ ] [ ]\n"\
  "1 [ ] [ ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "Robot Position: 2,2,NORTH\n"
end

def robot_2_2_west_map_with_4_blocks
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [█] [ ] [ ]\n"\
  "2 [ ] [█] [<] [█] [ ]\n"\
  "1 [ ] [ ] [█] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "Robot Position: 2,2,WEST\n"\
  "Blocks at positions:\n"\
  "[1, 2], [2, 1], [2, 3],\n"\
  "[3, 2]\n"
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

def robot_2_2_west_board_map_with_4_blocks
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
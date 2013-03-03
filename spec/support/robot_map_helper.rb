# encoding: UTF-8

def one_robot_r1_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [ ] [ ]\n"\
  "2 [ ] [ ] [Λ] [ ] [ ]\n"\
  "1 [ ] [ ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "R1's Position: 2,2,NORTH\n"
end

def one_robot_r1_with_blocks_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [█] [ ] [ ]\n"\
  "2 [ ] [█] [Λ] [█] [ ]\n"\
  "1 [ ] [ ] [█] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "R1's Position: 2,2,NORTH\n"\
  "R1's Blocks at Positions:\n"\
  "[1, 2], [2, 1], [2, 3],\n"\
  "[3, 2]\n"
end

def two_robots_r1_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [ ] [ ]\n"\
  "2 [ ] [ ] [ ] [ ] [ ]\n"\
  "1 [ ] [Λ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "R1's Position: 1,1,NORTH\n"
end

def two_robots_r2_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [V] [ ]\n"\
  "2 [ ] [ ] [ ] [ ] [ ]\n"\
  "1 [ ] [ ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "R2's Position: 3,3,SOUTH\n"
end

def two_robots_r1_with_blocks_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [ ] [ ]\n"\
  "2 [ ] [█] [ ] [ ] [ ]\n"\
  "1 [█] [Λ] [█] [ ] [ ]\n"\
  "0 [ ] [█] [ ] [ ] [ ]\n"\
  "R1's Position: 1,1,NORTH\n"\
  "R1's Blocks at Positions:\n"\
  "[0, 1], [1, 0], [1, 2],\n"\
  "[2, 1]\n"
end

def two_robots_r2_with_blocks_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [█] [ ]\n"\
  "3 [ ] [ ] [█] [V] [█]\n"\
  "2 [ ] [ ] [ ] [█] [ ]\n"\
  "1 [ ] [ ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "R2's Position: 3,3,SOUTH\n"\
  "R2's Blocks at Positions:\n"\
  "[2, 3], [3, 2], [3, 4],\n"\
  "[4, 3]\n"
end

def robot_north_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [ ] [ ]\n"\
  "2 [ ] [ ] [Λ] [ ] [ ]\n"\
  "1 [ ] [ ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"
end

def robot_east_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [ ] [ ]\n"\
  "2 [ ] [ ] [>] [ ] [ ]\n"\
  "1 [ ] [ ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"
end

def robot_south_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [ ] [ ]\n"\
  "2 [ ] [ ] [V] [ ] [ ]\n"\
  "1 [ ] [ ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"
end

def robot_west_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [ ] [ ]\n"\
  "2 [ ] [ ] [<] [ ] [ ]\n"\
  "1 [ ] [ ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"
end

def robot_and_blocks_map
  "   0   1   2   3   4\n"\
  "4 [ ] [█] [ ] [█] [ ]\n"\
  "3 [█] [ ] [█] [ ] [█]\n"\
  "2 [ ] [█] [ ] [█] [ ]\n"\
  "1 [█] [ ] [█] [ ] [█]\n"\
  "0 [ ] [█] [ ] [█] [<]\n"
end
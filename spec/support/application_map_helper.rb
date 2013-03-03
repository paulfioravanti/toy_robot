# encoding: UTF-8

def empty_application_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [ ] [ ]\n"\
  "2 [ ] [ ] [ ] [ ] [ ]\n"\
  "1 [ ] [ ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "Robots on the Board:\n"\
  "None\n"\
  "Hint: PLACE a robot first.\n"
end

def one_robot_application_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [ ] [ ]\n"\
  "2 [ ] [ ] [Λ] [ ] [ ]\n"\
  "1 [ ] [ ] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "Robots on the Board:\n"\
  "Name: R1\n"\
  "R1's Position: 2,2,NORTH\n"\
  "-------\n"
end

def one_robot_with_blocks_application_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [█] [ ] [ ]\n"\
  "2 [ ] [█] [V] [█] [ ]\n"\
  "1 [ ] [ ] [█] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "Robots on the Board:\n"\
  "Name: R1\n"\
  "R1's Position: 2,2,SOUTH\n"\
  "R1's Blocks at Positions:\n"\
  "[1, 2], [2, 1], [2, 3],\n"\
  "[3, 2]\n"\
  "-------\n"
end

def two_robots_application_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [ ] [ ]\n"\
  "3 [ ] [ ] [ ] [<] [ ]\n"\
  "2 [ ] [ ] [ ] [ ] [ ]\n"\
  "1 [ ] [>] [ ] [ ] [ ]\n"\
  "0 [ ] [ ] [ ] [ ] [ ]\n"\
  "Robots on the Board:\n"\
  "Name: R1\n"\
  "R1's Position: 1,1,EAST\n"\
  "-------\n"\
  "Name: R2\n"\
  "R2's Position: 3,3,WEST\n"\
  "-------\n"
end

def two_robots_with_blocks_application_map
  "   0   1   2   3   4\n"\
  "4 [ ] [ ] [ ] [█] [ ]\n"\
  "3 [ ] [ ] [█] [<] [█]\n"\
  "2 [ ] [█] [ ] [█] [ ]\n"\
  "1 [█] [>] [█] [ ] [ ]\n"\
  "0 [ ] [█] [ ] [ ] [ ]\n"\
  "Robots on the Board:\n"\
  "Name: R1\n"\
  "R1's Position: 1,1,EAST\n"\
  "R1's Blocks at Positions:\n"\
  "[0, 1], [1, 0], [1, 2],\n"\
  "[2, 1]\n"\
  "-------\n"\
  "Name: R2\n"\
  "R2's Position: 3,3,WEST\n"\
  "R2's Blocks at Positions:\n"\
  "[2, 3], [3, 2], [3, 4],\n"\
  "[4, 3]\n"\
  "-------\n"
end
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

def twenty_five_robot_board
  "   0   1   2   3   4\n"\
  "4 [Λ] [>] [V] [<] [Λ]\n"\
  "3 [<] [Λ] [>] [V] [<]\n"\
  "2 [V] [<] [Λ] [>] [V]\n"\
  "1 [>] [V] [<] [Λ] [>]\n"\
  "0 [Λ] [>] [V] [<] [Λ]\n"\
  "Robots on the Board:\n"\
  "Name: R1\n"\
  "R1's Position: 0,0,NORTH\n"\
  "-------\n"\
  "Name: R2\n"\
  "R2's Position: 0,1,EAST\n"\
  "-------\n"\
  "Name: R3\n"\
  "R3's Position: 0,2,SOUTH\n"\
  "-------\n"\
  "Name: R4\n"\
  "R4's Position: 0,3,WEST\n"\
  "-------\n"\
  "Name: R5\n"\
  "R5's Position: 0,4,NORTH\n"\
  "-------\n"\
  "Name: R6\n"\
  "R6's Position: 1,0,EAST\n"\
  "-------\n"\
  "Name: R7\n"\
  "R7's Position: 1,1,SOUTH\n"\
  "-------\n"\
  "Name: R8\n"\
  "R8's Position: 1,2,WEST\n"\
  "-------\n"\
  "Name: R9\n"\
  "R9's Position: 1,3,NORTH\n"\
  "-------\n"\
  "Name: R10\n"\
  "R10's Position: 1,4,EAST\n"\
  "-------\n"\
  "Name: R11\n"\
  "R11's Position: 2,0,SOUTH\n"\
  "-------\n"\
  "Name: R12\n"\
  "R12's Position: 2,1,WEST\n"\
  "-------\n"\
  "Name: R13\n"\
  "R13's Position: 2,2,NORTH\n"\
  "-------\n"\
  "Name: R14\n"\
  "R14's Position: 2,3,EAST\n"\
  "-------\n"\
  "Name: R15\n"\
  "R15's Position: 2,4,SOUTH\n"\
  "-------\n"\
  "Name: R16\n"\
  "R16's Position: 3,0,WEST\n"\
  "-------\n"\
  "Name: R17\n"\
  "R17's Position: 3,1,NORTH\n"\
  "-------\n"\
  "Name: R18\n"\
  "R18's Position: 3,2,EAST\n"\
  "-------\n"\
  "Name: R19\n"\
  "R19's Position: 3,3,SOUTH\n"\
  "-------\n"\
  "Name: R20\n"\
  "R20's Position: 3,4,WEST\n"\
  "-------\n"\
  "Name: R21\n"\
  "R21's Position: 4,0,NORTH\n"\
  "-------\n"\
  "Name: R22\n"\
  "R22's Position: 4,1,EAST\n"\
  "-------\n"\
  "Name: R23\n"\
  "R23's Position: 4,2,SOUTH\n"\
  "-------\n"\
  "Name: R24\n"\
  "R24's Position: 4,3,WEST\n"\
  "-------\n"\
  "Name: R25\n"\
  "R25's Position: 4,4,NORTH\n"\
  "-------\n"
end

def one_robot_twenty_four_blocks
  "   0   1   2   3   4\n"\
  "4 [█] [█] [█] [█] [V]\n"\
  "3 [█] [█] [█] [█] [█]\n"\
  "2 [█] [█] [█] [█] [█]\n"\
  "1 [█] [█] [█] [█] [█]\n"\
  "0 [█] [█] [█] [█] [█]\n"\
  "Robots on the Board:\n"\
  "Name: R1\n"\
  "R1's Position: 4,4,SOUTH\n"\
  "R1's Blocks at Positions:\n"\
  "[0, 0], [0, 1], [0, 2],\n"\
  "[0, 3], [0, 4], [1, 0],\n"\
  "[1, 1], [1, 2], [1, 3],\n"\
  "[1, 4], [2, 0], [2, 1],\n"\
  "[2, 2], [2, 3], [2, 4],\n"\
  "[3, 0], [3, 1], [3, 2],\n"\
  "[3, 3], [3, 4], [4, 0],\n"\
  "[4, 1], [4, 2], [4, 3]\n"\
  "-------\n"
end
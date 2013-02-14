# encoding: UTF-8

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
  "4 [ ] [X] [ ] [X] [ ]\n"\
  "3 [X] [ ] [X] [ ] [X]\n"\
  "2 [ ] [X] [ ] [X] [ ]\n"\
  "1 [X] [ ] [X] [ ] [X]\n"\
  "0 [ ] [X] [ ] [X] [<]\n"
end
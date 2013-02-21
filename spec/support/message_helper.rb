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
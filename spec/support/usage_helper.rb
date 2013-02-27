def usage_message
  "Valid Commands:\n"\
  "PLACE X,Y,F eg: PLACE 0,0,NORTH\n"\
  "MOVE\n"\
  "LEFT\n"\
  "RIGHT\n"\
  "REPORT\n"\
  "EXIT\n"\
  "-------\n"
end

def extended_usage_message
  "*** EXTENDED MODE ***\n"\
  "Valid Commands:\n"\
  "PLACE X,Y,F [ROBOT_NAME] eg: PLACE 0,0,NORTH KRYTEN\n"\
  "MOVE\n"\
  "LEFT\n"\
  "RIGHT\n"\
  "REPORT\n"\
  "SPIN\n"\
  "BLOCK\n"\
  "MAP [BOARD]\n"\
  "HELP\n"\
  "EXIT\n"\
  "-------\n"
end

def prompt
  "> "
end
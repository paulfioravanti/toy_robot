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
  "New Robot:\n"\
  "  PLACE X,Y,F [<ROBOT_NAME>]\n"\
  "Re-place Robot:\n"\
  "  PLACE X,Y,F <ROBOT_NAME>\n"\
  "MOVE [<ROBOT_NAME>]\n"\
  "LEFT [<ROBOT_NAME>]\n"\
  "RIGHT [<ROBOT_NAME>]\n"\
  "REPORT [<ROBOT_NAME>]\n"\
  "SPIN [<ROBOT_NAME>]\n"\
  "BLOCK [<ROBOT_NAME>]\n"\
  "MAP [<ROBOT_NAME>] [BOARD]\n"\
  "HELP\n"\
  "EXIT\n"\
  "-------\n"
end

def prompt
  "> "
end
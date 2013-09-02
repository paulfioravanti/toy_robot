require 'colorable'

module ToyRobot
  # A Module representing the ExtendedApplication usage message
  module ExtendedUsage
    extend Colorable # bring in as class methods

    def self.message
      "#{header}\n"\
      "#{place}\n"\
      "#{move}\n"\
      "#{left}\n"\
      "#{right}\n"\
      "#{report}\n"\
      "#{spin}\n"\
      "#{block}\n"\
      "#{map}\n"\
      "#{help}\n"\
      "#{exit}\n"\
      "#{footer}\n"
    end

    private
    module_function

    def header
      "#{bold_green "*** EXTENDED MODE ***"}\n"\
      "#{yellow "Valid Commands:"}"
    end

    def place
      "#{cyan "New Robot"}:\n"\
      "  PLACE X,Y,F [<ROBOT_NAME>]\n"\
      "#{cyan "Re-place Robot"}:\n"\
      "  PLACE X,Y,F <ROBOT_NAME>"
    end

    def move; "MOVE [<ROBOT_NAME>]"; end
    def left; "LEFT [<ROBOT_NAME>]"; end
    def right; "RIGHT [<ROBOT_NAME>]"; end
    def report; "REPORT [<ROBOT_NAME>]"; end
    def spin; "SPIN [<ROBOT_NAME>]"; end
    def block; "BLOCK [<ROBOT_NAME>]"; end
    def map; "MAP [<ROBOT_NAME>] [BOARD]"; end
    def help; "HELP"; end
    def exit; "EXIT"; end
    def footer; "-------"; end
  end
end
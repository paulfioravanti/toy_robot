module ToyRobot
  module Usage
    module_function

    def output
      "#{header}\n"\
      "#{place}\n"\
      "#{move}\n"\
      "#{left}\n"\
      "#{right}\n"\
      "#{report}\n"\
      "#{exit}\n"\
      "#{footer}\n"
    end

    def header; "Valid Commands:"; end
    def place; "PLACE X,Y,F eg: PLACE 0,0,NORTH"; end
    def move; "MOVE"; end
    def left; "LEFT"; end
    def right; "RIGHT"; end
    def report; "REPORT"; end
    def exit; "EXIT"; end
    def footer; "-------"; end
  end
end

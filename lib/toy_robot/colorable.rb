module ToyRobot
  module Colorable
    def colorize(text, color_code); "\e[#{color_code}m#{text}\e[0m"; end
    def red(text); colorize(text, 31); end
    def bold_red(text); colorize(text, "1;31"); end
    def green(text); colorize(text, 32); end
    def bold_green(text); colorize(text, "1;32"); end
    def yellow(text); colorize(text, 33); end
    def magenta(text); colorize(text, 35); end
    def cyan(text); colorize(text, 36); end
    def bold_cyan(text); colorize(text, "1;36"); end
    def bold_white(text); colorize(text, "1;37"); end
  end
end
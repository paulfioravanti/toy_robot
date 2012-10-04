module ToyRobot
  module ToyRobotHelper
    def numerical?(*args)
      args.each { |arg| return false if arg.to_s.match(/[^-?\d+]/) }
      true
    end
  end
end
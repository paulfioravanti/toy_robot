module ToyRobot
  module ToyRobotHelper
    def numerical?(*args)
      args.each { |arg| true if Integer(arg) rescue return false }
    end
  end
end
require 'simplecov'

require 'rspec'
Dir[File.dirname(__FILE__) + '/support/*.rb'].each {|file| require file }

include ToyRobot
include Utilities
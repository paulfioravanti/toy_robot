require 'simplecov'

require 'rspec'
require 'rspec/its'
Dir[File.dirname(__FILE__) + '/support/*.rb'].each {|file| require file }

include ToyRobot
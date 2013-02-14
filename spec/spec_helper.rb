require 'simplecov'
SimpleCov.start

require 'rspec'
# require 'support/utilities'
# Dir["support/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__) + '/support/*.rb'].each {|file| require file }

include ToyRobot
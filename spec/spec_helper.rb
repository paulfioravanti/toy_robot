if ENV['TRAVIS']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
  require 'simplecov'
end

require 'rspec'
require 'rspec/its'
Dir[File.dirname(__FILE__) + '/support/*.rb'].each {|file| require file }

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

include ToyRobot

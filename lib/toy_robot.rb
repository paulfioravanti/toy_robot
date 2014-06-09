$LOAD_PATH << File.join(File.dirname(__FILE__), "toy_robot")
require 'version'
require 'cli'
require 'application'
require 'board'
require 'robot'
require 'position'

require 'extended_application'
require 'extended_board'
require 'extended_robot'
require 'block'
require 'mappable'
require 'robot_map'
require 'board_map'
# Silence baffling deprecation notice
I18n.enforce_available_locales = true
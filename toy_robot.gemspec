require File.expand_path('../lib/toy_robot/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "toy_robot"
  gem.version       = ToyRobot::VERSION
  gem.summary       = %q{Toy Robot Simulator}
  gem.description   = %q{A simulation of a toy robot moving on a square tabletop}
  gem.license       = "MIT"
  gem.authors       = ["Paul Fioravanti"]
  gem.email         = "paul.fioravanti@gmail.com"
  gem.homepage      = "https://rubygems.org/gems/toy_robot"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rake', '~> 10.4'
  gem.add_development_dependency 'rspec', '~> 3.1'
  gem.add_development_dependency 'rspec-its' # re-test to get rid of this gem
  gem.add_development_dependency 'rspec-legacy_formatters'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency 'yard', '~> 0.8'
  gem.add_development_dependency 'thor', '~> 0.17'
  gem.add_development_dependency 'activemodel', '~> 4.1'
end

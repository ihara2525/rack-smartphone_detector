# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/smartphone_detector/version'

Gem::Specification.new do |gem|
  gem.name        = 'rack-smartphone_detector'
  gem.version     = Rack::SmartphoneDetector::VERSION
  gem.authors     = ['Masahiro Ihara']
  gem.email       = ['ihara2525@gmail.com']
  gem.homepage    = 'https://github.com/ihara2525/rack-smartphone_detector'
  gem.description = 'Simple Rack middleware which detect the request comes from smartphone'
  gem.summary     = 'Simple Rack middleware which detect the request comes from smartphone'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'rack', '~> 1.4'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'rack-test'
end

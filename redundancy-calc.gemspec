# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redundancy-calc/version'

Gem::Specification.new do |spec|
  spec.name          = "redundancy-calc"
  spec.version       = RedundancyCalc::VERSION
  spec.authors       = ["Federico Tomassetti"]
  spec.email         = ["f.tomassetti@gmail.com"]
  spec.description   = %q{This project contains utilities to evaluate redundancy}
  spec.summary       = %q{This project contains utilities to evaluate redundancy}
  spec.homepage      = ""
  spec.license       = "Apache license 2"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "lightmodels"
  spec.add_dependency "java-lightmodels"
  spec.add_dependency "ruby-lightmodels"
  spec.add_dependency "commander"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubygems-tasks"
end

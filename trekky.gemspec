# encoding: utf-8

Gem::Specification.new do |s|
  s.name              = "trekky"
  s.version           = "0.0.2"
  s.summary           = "Simple, very simple, sass and haml compiler for dear designer friend."
  s.description       = "Simple, very simple, sass and haml compiler."
  s.authors           = ["Lucas Florio"]
  s.email             = ["lucasefe@gmail.com"]
  s.homepage          = "http://github.com/lucasefe/trekky"
  s.files             = []
  s.license           = "MIT"
  s.executables.push('trekky')
  s.add_dependency 'clap', '~> 1.0'
  s.add_dependency 'sass', '~> 3.3'
  s.add_dependency 'haml', '~> 4.0'
  s.add_dependency 'fs-event', '~> 0.9'
end

# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "walter_bishop/version"

Gem::Specification.new do |s|
  s.name        = "walter_bishop"
  s.version     = WalterBishop::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Albert Bellonch"]
  s.email       = ["albert@itnig.net"]
  s.homepage    = "http://itnig.net"
  s.summary     = %q{A madly erratic classifier for TV Series and Movies}
  s.description = %q{-}

  s.rubyforge_project = "walter_bishop"

  s.bindir             = 'bin'
  s.executables        = ['walter_bishop']
  s.default_executable = 'walter_bishop'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
  s.add_dependency "json"
  s.add_development_dependency "rspec"
  s.add_development_dependency "ZenTest"
end

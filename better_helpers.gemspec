# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'better_helpers/version'

Gem::Specification.new do |s|
  s.name          = "better_helpers"
  s.version       = BetterHelpers::VERSION
  s.authors       = ["tulios"]
  s.email         = ["ornelas.tulio@gmail.com"]
  s.description   = %q{TODO: Write a gem description}
  s.summary       = %q{TODO: Write a gem summary}
  s.homepage      = "https://github.com/tulios/better_helpers"
  s.license       = "MIT"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "activesupport"
  s.add_dependency "actionview"

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end

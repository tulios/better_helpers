# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'better_helpers/version'

Gem::Specification.new do |s|
  s.name          = "better_helpers"
  s.version       = BetterHelpers::VERSION
  s.authors       = ["tulios"]
  s.email         = ["ornelas.tulio@gmail.com"]
  s.description   = %q{It is a better way to organize and maintain your Rails helpers. It's provide a simple pattern to keep your helpers scoped, avoiding conflicts in the global namespace}
  s.summary       = %q{It is a better way to organize and maintain your Rails helpers}
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

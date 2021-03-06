# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_search/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_search"
  spec.version       = SimpleSearch::VERSION
  spec.authors       = ["Premysl Donat"]
  spec.email         = ["donat@uol.cz"]
  spec.description   = %q{Library for common end-user filtering of your ActiveRecord models.}
  spec.summary       = %q{Filtering ActiveRecord models with forms.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "activerecord", '~> 4.0'
  spec.add_development_dependency "sqlite3"

end

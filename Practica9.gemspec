# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'Practica9/version'

Gem::Specification.new do |spec|
  spec.name          = "Practica12"
  spec.version       = Practica12::VERSION
  spec.authors       = ["Abraham and Christian"]
  spec.email         = ["abrahamblg@hotmail.es and christian-siedler@hotmail.com"]
  spec.description   = %q{Matrices densas y dispersas}
  spec.summary       = %q{MAtrices densas y dispersas. Sobrecargadas las operaciones }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end

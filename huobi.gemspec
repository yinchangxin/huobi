# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'huobi/version'

Gem::Specification.new do |spec|
  spec.name          = "huobi"
  spec.version       = Huobi::VERSION
  spec.authors       = ["tomlion"]
  spec.email         = ["qycpublic@gmail.com"]
  spec.description   = %q{Ruby wrapper for huobi api}
  spec.summary       = %q{Ruby wrapper for huobi api}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.8"
  spec.add_dependency "json", "~> 1.7"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
end

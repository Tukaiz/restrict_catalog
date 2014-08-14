# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'restrict_catalog/version'

Gem::Specification.new do |spec|
  spec.name          = "restrict_catalog"
  spec.version       = RestrictCatalog::VERSION
  spec.authors       = ["tatums"]
  spec.email         = ["tatum@ashlandstudios.com"]
  spec.summary       = %q{This is a feature gem for backstage 2.}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end

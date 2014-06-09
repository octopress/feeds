# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'octopress-feeds/version'

Gem::Specification.new do |spec|
  spec.name          = "octopress-feeds"
  spec.version       = Octopress::Ink::Feeds::VERSION
  spec.authors       = ["Brandon Mathis"]
  spec.email         = ["brandon@imathis.com"]
  spec.summary       = %q{A nice RSS feeds for Octopress and Jekyll sites.}
  spec.description   = %q{A nice RSS feeds for Octopress and Jekyll sites.}
  spec.homepage      = "https://github.com/octopress/feeds"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "octopress"
  
  spec.add_runtime_dependency "octopress-ink", ">= 1.0.0.rc.8"
end

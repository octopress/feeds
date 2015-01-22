# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'octopress-feeds/version'

Gem::Specification.new do |spec|
  spec.name          = "octopress-feeds"
  spec.version       = Octopress::Feeds::VERSION
  spec.authors       = ["Brandon Mathis"]
  spec.email         = ["brandon@imathis.com"]
  spec.summary       = %q{A nice RSS feeds for Octopress and Jekyll sites.}
  spec.description   = %q{A nice RSS feeds for Octopress and Jekyll sites.}
  spec.homepage      = "https://github.com/octopress/feeds"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n").grep(%r{^(bin\/|lib\/|assets\/|changelog|readme|license)}i)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_runtime_dependency "octopress-ink", ">= 1.0.0.rc"
  spec.add_runtime_dependency "octopress-abort-tag"
  spec.add_runtime_dependency "octopress-return-tag"
  spec.add_runtime_dependency "octopress-date-format"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "octopress"
  spec.add_development_dependency "clash"
  spec.add_development_dependency "octopress-linkblog"
  spec.add_development_dependency "octopress-multilingual"

  if RUBY_VERSION >= "2"
    spec.add_development_dependency "pry-byebug"
  end
end

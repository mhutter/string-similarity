# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'string/similarity/version'

Gem::Specification.new do |spec|
  spec.name          = 'string-similarity'
  spec.version       = String::Similarity::VERSION
  spec.authors       = ['Manuel Hutter']
  spec.email         = ['manuel@hutter.io']

  spec.summary       = %q{Various methods for calculating string similarities.}
  spec.description   = <<-EOT
== Description

This gem provides some methods for calculating similarities of two strings.

=== Currently implemented

- Cosine similarity
- Levenshtein distance/similarity

=== Planned

- Hamming similarity
  EOT
  spec.homepage      = 'https://github.com/mhutter/string-similarity'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
end

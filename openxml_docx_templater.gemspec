# frozen_string_literal: true

# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openxml_docx_templater/version'

Gem::Specification.new do |spec|
  spec.name          = 'openxml_docx_templater'
  spec.version       = OpenxmlDocxTemplater::VERSION
  spec.authors       = ['Andrew Ageev']
  spec.email         = ['ageev86@gmail.com']

  spec.summary       = 'Simple creation .docx files by templates'
  spec.description   = 'Simple creation .docx files by templates'
  spec.homepage      = 'https://github.com/AgeevAndrew/openxml_docx_templater'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_dependency 'rubyzip'

  spec.add_development_dependency 'rspec'
end

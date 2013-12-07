# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kublai/version'

Gem::Specification.new do |spec|
  spec.name          = "kublai"
  spec.version       = Kublai::VERSION
  spec.authors       = ["Lewis Clayton"]
  spec.email         = ["mail@l.ew.is"]
  spec.date          = '2013-12-07'
  spec.description   = %q{Ruby wrapper for the BTCChina Trade API. BTCChina allows you to trade Chinese Yuan (CNY) for Bitcoins (BTC) or Bitcoins for Chinese Yuan.}
  spec.summary       = %q{Ruby wrapper for the BTCChina Trade API.}
  spec.homepage      = 'http://l.ew.is/kublai_btcchina_api_ruby/'
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency('json', '~> 1.8.1')
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.has_rdoc      = false
end
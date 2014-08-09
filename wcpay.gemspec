# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wcpay/version'

Gem::Specification.new do |spec|
  spec.name          = "wcpay"
  spec.version       = Alipay::VERSION
  spec.authors       = ["Leon"]
  spec.email         = ["leon.zcf@gmail.com"]
  spec.description   = %q{An unofficial simple wcpay gem}
  spec.summary       = %q{An unofficial simple wcpay gem}
  spec.homepage      = "https://github.com/oldfritter/wcpay"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  # spec.add_dependency 'nokogiri', '~> 1.6.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "fakeweb"
end

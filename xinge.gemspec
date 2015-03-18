# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xinge/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-for-xinge"
  spec.version       = Xinge::VERSION
  spec.authors       = ["Robot Jiang"]
  spec.email         = ["robot.z.jiang@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  end

  spec.summary       = %q{A Ruby portal for Tencent Xinge}
  spec.description   = %q{腾讯 信鸽 Rest API for Ruby}
  spec.homepage      = "https://github.com/RobotJiang/ruby-for-xinge"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "httparty", "~> 0.13.3"
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end

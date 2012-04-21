require File.expand_path('../lib/gestopft/version', __FILE__)

Gem::Specification.new do |g|
  g.name = "gestopft"
  g.version = Gestopft::VERSION
  g.summary = "Framework for CLI Application"
  g.executables = `git ls-files -- bin/*`.split("\n").map {|f| File.basename(f) }
  g.files = `git ls-files`.split("\n")
  g.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  g.authors = ["aereal"]
  g.email = ["aereal@kerare.org"]
  g.homepage = "https://github.com/aereal/gestopft"
  g.require_path = ["lib"]
  g.platform = Gem::Platform::RUBY

  g.add_development_dependency 'rspec', ['~> 2.8.0']
  g.add_development_dependency 'rake', ['~> 0.9.2']
  g.add_development_dependency 'guard-bundler'
  g.add_development_dependency 'guard-rspec'
  g.add_development_dependency 'guard-spork'
  g.add_development_dependency 'spork'
  g.add_development_dependency 'fivemat'
end

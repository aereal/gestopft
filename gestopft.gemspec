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
end

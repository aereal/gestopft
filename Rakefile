require "rubygems"
require "rake/gempackagetask"

$: << "lib"
require "gestopft"

gemspec = Gem::Specification.new do |g|
	g.platform = Gem::Platform::RUBY
	g.summary = "Framework for CLI Application"
	g.name = "gestopft"
	g.version = "0.0.2"
	g.author = "aereal"
	g.email = "trasty.loose@gmail.com"
	g.files = ["README.rdoc", ".autotest", ".rspec",
		Dir.glob("lib/**/*.rb"), Dir.glob("spec/**/*.rb")
	]
	g.homepage = "http://github.com/aereal/gestopft"
	g.require_path = "lib"
end

Rake::GemPackageTask.new(gemspec) do |pkg|
	pkg.need_tar = true
	pkg.gem_spec = gemspec
end


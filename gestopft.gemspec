# vim:set ft=ruby:

Gem::Specification.new do |g|
	g.name = "gestopft"
	g.version = "0.0.1"
	g.summary = "Framework for CLI Application"
	g.files = ["README.rdoc", ".rspec", ".autotest",
		Dir.glob("lib/**/*.rb"), Dir.glob("spec/**/*.rb")
	]
	g.authors = ["AOKI,Hanae"]
	g.email = "trasty.loose@gmail.com"
	g.homepage = "http://github.com/aereal/gestopft"
end


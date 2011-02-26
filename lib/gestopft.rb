# -*- coding: utf-8 -*-

module Gestopft
	VERSION = '0.0.1'

	class Error < ::StandardError; end
	class NotSatisfiedRequirements < Error; end
end

class Gestopft::App
	def self.required(*args)
		(@@requirements ||= []).concat(args.map {|arg|
			"--" + arg.to_s
		})
	end

	def run(argv)
		unless @@requirements.all? {|req| argv.include? req }
			raise Gestopft::NotSatisfiedRequirements
		end
	end
end

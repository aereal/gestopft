# -*- coding: utf-8 -*-

module Gestopft
	VERSION = '0.0.1'

	class Error < ::StandardError; end
	class NotSatisfiedRequirements < Error; end
end

class Gestopft::App
	@given_options = {}
	@expected_options = []

	class << self
		def options(*opts)
			with_args, *no_args = opts.last.class == Hash ?
				opts.reverse : [{}, *opts]
			(@expected_options ||= []).concat(no_args).concat(with_args.keys)
		end

		def run(argv)
			new(argv)
		end
	end

	def given_options
		self.class.module_eval { @given_options }
	end

	def expected_options
		self.class.module_eval { @expected_options }
	end
end


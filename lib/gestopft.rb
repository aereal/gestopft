# -*- coding: utf-8 -*-

require "gestopft/core_ext"

module Gestopft
	VERSION = '0.0.1'

	module Constants
		class Error < ::StandardError; end
		class NotSatisfiedRequirements < Error; end
	end

	autoload :Option, 'gestopft/option'
end

class Gestopft::App
	include Gestopft::Constants

	@expected_options = {}

	def self.expected_options
		@expected_options ||= {}
	end

	def self.options(*opts)
		with_args, *no_args =
			opts.last.class == Hash ? opts.reverse : [{}, *opts]
		expected_options.update(with_args).update(
			Hash[no_args.zip(
				Array.new(no_args.size, true)
			)]
		)
	end

	def self.run(argv)
		new(argv).parse_arg!
	end

	attr_reader :given_options

	def initialize(argv)
		@argv = argv.option_args
		@expected_options = self.class.expected_options
		@given_options = {}
	end

	def parse_arg!
		@expected_options.select {|name, expect| expect }.each do |name, expect|
			opt = name.to_option
			case expect
			when true
				if @argv.delete(opt)
					@given_options[name] = expect
				else
					raise NotSatisfiedRequirements
				end
			when Array # Optional argument
				if pos = @argv.find_index(opt)
					arg = @argv[pos + 1]
					if arg && arg.option?
						@argv.delete(opt)
						@given_options[name] = true
					else
						opt, param = @argv.slice!(pos, 2)
						@given_options[name] = param
					end
				end
			when Module
				if pos = @argv.find_index(opt)
					arg = @argv[pos + 1]
					if arg && !arg.option?
						opt, param = @argv.slice!(pos, 2)
						@given_options[name] = param
					else
						raise NotSatisfiedRequirements
					end
				else
					raise NotSatisfiedRequirements
				end
			end
		end
	else
		self
	end
end


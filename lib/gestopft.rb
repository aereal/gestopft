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

	def self.expected_options
		@expected_options ||= []
	end

	#def self.options(*opts)
	#	with_args, *no_args =
	#		opts.last.class == Hash ? opts.reverse : [{}, *opts]
	#	expected_options.update(with_args).update(
	#		Hash[no_args.zip(
	#			Array.new(no_args.size, true)
	#		)]
	#	)
	#end

	def self.option(name, args={})
		expected_options << Gestopft::Option.new(name, args)
	end

	def self.run(argv)
		new(argv).parse_arg!
	end

	class << self
		alias_method :opt, :option
	end

	attr_reader :given_options

	def initialize(argv)
		@argv = argv.option_args
		@expected_options = self.class.expected_options
		@given_options = {}
	end

	def parse_arg!
		@expected_options.each do |opt|
			if opt.require_args?
				if pos = @argv.find_index(opt.option_name)
					params = @argv[pos + 1, opt.arity]
					unless (
						params &&
						params.none? {|prm| prm.option? } &&
						params.size == opt.arity
					)
						raise NotSatisfiedRequirements
					end
					@given_options[opt.name] = params
				end
			else
				@given_options[opt.name] = @argv.delete(opt.option_name)
			end
		end
	else
		self
	end
end


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

	def self.expectation
		@expectation ||= []
	end

	def self.option(name, args={})
		expectation << Gestopft::Option.new(name, args)
	end

	def self.run(argv)
		new(argv).parse_arg!
	end

	class << self
		alias_method :opt, :option
	end

	attr_reader :options

	def initialize(argv)
		@argv = argv.option_args
		@expectation = self.class.expectation
		@options = {}
	end

	def parse_arg!
		@expectation.each do |opt|
			if opt.require_args?
				if (
					pos = @argv.find_index(opt.option_name) and
					params = @argv[pos + 1, opt.arity] and
					params.none? {|param| param.option? } and
					params.size == opt.arity
				)
					@argv.slice!(pos, opt.arity + 1)
					@argv.compact!
					@options[opt.name] = params
				else
					raise NotSatisfiedRequirements
				end
			else
				@options[opt.name] = @argv.delete(opt.option_name)
			end
		end
	else
		self
	end
end


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

	def self.option(name, *args)
		p desc = args.find {|arg| arg.is_a? String }
		p params = args.find {|arg| arg.is_a? Array }
		expectation << Gestopft::Option.new(name, {
			:desc => desc,
			:params => params
		})
	end

	def self.run(argv)
		new(argv).parse_arg.dispatch
	end

	def self.commands
		public_instance_methods - Gestopft::App.public_instance_methods
	end

	attr_reader :options

	def initialize(argv)
		@argv = argv.option_args
		@expectation = self.class.expectation
		@options = {}
		@commands = self.class.commands.map {|cmd| method(cmd) }
	end

	def parse_arg
		@expectation.each do |opt|
			if opt.require_args?
				if (
					pos = @argv.find_index(opt.option_name) and
					params = @argv[pos + 1, opt.arity] and
					params.none? {|param| param.option? } and
					params.size == opt.arity
				)
					@options[opt.name] = params
				else
					raise NotSatisfiedRequirements
				end
			else
				@options[opt.name] = opt.option_name
			end
		end
		self
	end

	def dispatch
		argv = @argv.reject {|arg| arg.option? }
		@commands.each do |cmd|
			if pos = argv.find_index(cmd.name.to_s)
				params = argv[pos + 1, cmd.arity.abs]
				return cmd.call(*params)
			end
		end
		self
	end
end


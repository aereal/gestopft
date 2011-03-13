# -*- coding: utf-8 -*-

module Gestopft
	VERSION = '0.0.1'

	class Error < ::StandardError; end
	class NotSatisfiedRequirements < Error; end
end

class Gestopft::App
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
		new(argv)
	end

	attr_reader :given_options

	def initialize(argv)
		@argv = (seppos = argv.index('--')) ? argv[0...seppos] : argv.dup
		@expected_options = self.class.expected_options
		@given_options = {}

		@expected_options.select {|name, expect| expect }.each do |name, expect|
			opt = '--' + name.to_s.gsub('_', '-')
			case expect
			when true
				if @argv.delete(opt)
					@given_options[name] = expect
				end
			when Array # Optional argument
				expected_type = expect.first
				if pos = @argv.index(opt)
					arg = @argv[pos + 1]
					if arg[0..2] == '--'
						@argv.delete(opt)
						@given_options[name] = true
					else
						@argv[pos, 2] = nil
						@argv.compact!
						@given_options[name] = arg
					end
				end
			end
		end
	end
end


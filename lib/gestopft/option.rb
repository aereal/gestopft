# encoding: utf-8

class Gestopft::Option
	attr_reader :name, :params

	def initialize(name, args={})
		@name = name
		@params = args[:params]
	end

	def option_name
		@name.to_option
	end

	def require_args?
		!!@params
	end

	def arity
		@params.nil? ? -1 : @params.size
	end
end


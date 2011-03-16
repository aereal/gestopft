# encoding: utf-8

class Gestopft::Option
	attr_reader :name

	def initialize(name, expect={})
		@name = name
	end

	def option_name
		@name.to_option
	end
end


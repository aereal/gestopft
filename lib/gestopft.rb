# -*- coding: utf-8 -*-

require "gestopft/core_ext"

module Gestopft
	VERSION = '0.0.1'

	module Constants
		class Error < ::StandardError; end
		class NotSatisfiedRequirements < Error; end
	end

	autoload :App,    'gestopft/app'
	autoload :Option, 'gestopft/option'
end


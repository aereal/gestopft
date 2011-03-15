# encoding: utf-8

module ArrayExtension
	def option_args
		pos = index('--') ? slice(0...pos) : dup
	end
end

Array.send(:include, ArrayExtension)


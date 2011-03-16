# encoding: utf-8
# vim:set ft=ruby:

require "gestopft"

include Gestopft::Constants

describe Gestopft::Option do
	subject do
		Gestopft::Option.new(:my_option)
	end

	describe "#option_name" do
		it "is option string." do
			subject.option_name.should == '--my-option'
		end
	end
end


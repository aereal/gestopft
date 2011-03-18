# encoding: utf-8
# vim:set ft=ruby:

require "gestopft"

include Gestopft::Constants

describe Gestopft::Option do
	subject do
		Gestopft::Option.new(:my_option, :desc => "my description")
	end

	it "#option_name is option string." do
		subject.option_name.should == '--my-option'
	end

	context "when given a description." do
		it "#desc[ription] is the description about the option." do
			subject.desc.should == "my description"
			subject.description.should == "my description"
		end
	end

	context "when does not given a description." do
		subject do
			Gestopft::Option.new(:my_option)
		end

		it "#desc[ription] is empty." do
			subject.desc.should be_empty
			subject.description.should be_empty
		end
	end

	context "which requires parameters." do
		subject do
			Gestopft::Option.new(:delay, :params => %w(minute))
		end

		it "#require_args? is true" do
			subject.require_args?.should be_true
		end

		it "#arity is the arity of option." do
			subject.arity.should == 1
		end
	end

	context "which requires no parameter." do
		subject do
			Gestopft::Option.new(:verbose)
		end

		it "#require_args? is false" do
			subject.require_args?.should be_false
		end

		it "#arity is magic number which means the option takes no params." do
			subject.arity.should == -1
		end
	end
end


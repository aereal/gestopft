#!spec
# -*- coding: utf-8 -*-
# vim: set ft=ruby:

require "gestopft"

describe Gestopft::App do
	subject do
		Class.new(Gestopft::App)
	end

	describe ".required" do
		before :all do
			subject.module_eval do
				required :required_option
			end
		end

		it "succeeds when given complete arguments." do
			expect { subject.new.run(['--required_option']) }.
				should_not raise_error(Gestopft::NotSatisfiedRequirements)
		end

		it "fails when given incomplete arguments." do
			expect { subject.new.run([]) }.
				should raise_error(Gestopft::NotSatisfiedRequirements)
		end
	end
end


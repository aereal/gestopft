# -*- coding: utf-8 -*-
# vim: set ft=ruby:

require "gestopft"

describe Gestopft::App do
	describe ".options" do
		subject do
			Class.new(Gestopft::App)
		end

		context "given a option which requires no arguments." do
			before :all do
				subject.module_eval do
					options :with_no_args
				end
			end

			it "has a option which given." do
				subject.run(["--with-no-args"]).given_options.
					should include(:with_no_args)
			end

			it "does not have a option which does not given." do
				subject.run([]).given_options.
					should_not include(:does_not_given)
			end

			it "succeeds when given a option which requires no arguments." do
				expect { subject.run(["--with-no-args"]) }.
					should_not raise_error(Gestopft::Error)
			end

			it "succeeds when not given a option which requires no arguments." do
				expect { subject.run([]) }.
					should_not raise_error(Gestopft::Error)
			end
		end

		context "a option which may take a argument." do
			before :all do
				subject.module_eval do
					options :with_args => [String]
				end
			end

			it "has a option which given with taken value." do
				subject.run(%w(--with-args myargs)).given_options.
					should include(:with_args)
			end
		end
	end
end


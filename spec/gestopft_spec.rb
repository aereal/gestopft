# -*- coding: utf-8 -*-
# vim: set ft=ruby:

require "gestopft"

include Gestopft::Constants

describe Gestopft::App do
  subject do
    Class.new(Gestopft::App)
  end

  context "given a option which requires no arguments." do
    before :all do
      subject.module_eval do
        option :with_no_args
      end
    end

    it "has a option which given." do
      subject.run(%w(--with-no-args)).options.
        should include(:with_no_args)
    end

    it "does not have a option which does not given." do
      subject.run(%w(--with-no-args)).options.
        should_not include(:does_not_given)
    end

    it "succeeds when given a option which requires no arguments." do
      expect { subject.run(%w(--with-no-args)) }.
        should_not raise_error(Error)
    end

    it "succeeds when not given a option which is required." do
      expect { subject.run([]) }.
        should_not raise_error(NotSatisfiedRequirements)
    end
  end

  context "a option which require a argument." do
    before :all do
      subject.module_eval do
        option :delay, [:minute]
      end
    end

    it "has a option which given with taken parameter." do
      subject.run(%w(--delay 5)).options.
        should include(:delay => ['5'])
    end

    it "does not have a option which given without any arguments." do
      expect { subject.run(%w(--delay)) }.
        should raise_error(NotSatisfiedRequirements)
    end
  end

  context "when defined sub-commands" do
    before do
      subject.module_eval do
        def update
          :update
        end
      end
    end

    it ".commands is a array of available commands." do
      subject.commands.should == [:update]
    end

    it "#dispatch return value which of sub-command's" do
      subject.new(%w(update)).dispatch.should == subject.new([]).update
    end
  end

  context "when not defined sub-commands" do
    it ".commands is empty array." do
      subject.commands.should be_empty
    end
  end
end


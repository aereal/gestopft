# encoding: utf-8

class Gestopft::App
  include Gestopft::Constants

  def self.expectation
    @expectation ||= []
  end

  def self.option(name, *args)
    desc = args.find {|arg| arg.is_a? String }
    params = args.find {|arg| arg.is_a? Array }
    expectation << Gestopft::Option.new(name, {
      :desc => desc,
      :params => params
    })
  end

  def self.run(argv=ARGV)
    (app = new(argv)).parse_arg.dispatch
    app
  end

  def self.commands
    public_instance_methods - Gestopft::App.public_instance_methods
  end

  attr_reader :options

  def initialize(argv)
    @argv = argv.option_args
    @expectation = self.class.expectation
    @options = {}
    @commands = self.class.commands.map {|cmd| method(cmd) }
  end

  def parse_arg
    @expectation.each do |opt|
      if opt.require_args?
        if (
          pos = @argv.find_index(opt.option_name) and
          params = @argv[pos + 1, opt.arity] and
          params.none? {|param| param.option? } and
          params.size == opt.arity
        )
          @options[opt.name] = params
        else
          raise NotSatisfiedRequirements
        end
      else
        @options[opt.name] = opt.option_name
      end
    end
    self
  end

  def dispatch
    argv = @argv.reject {|arg| arg.option? }
    @commands.each do |cmd|
      if pos = argv.find_index(cmd.name.to_s)
        params = argv[pos + 1, cmd.arity.abs]
        return cmd.call(*params)
      end
    end
    send(:__default__)
  end

  def help_message
    msg = []
    msg << <<-BANNER.strip
Usage:
  $ #{File.basename($0)} [options] #{"command [args, ...]" unless @commands.empty?}
    BANNER

    unless @expectation.empty?
      msg << "Options: "
      @expectation.each do |opt|
        line = ["\t", opt.option_name]
        line << opt.params.map {|param|
          param.to_s.upcase
        }.join(' ') unless opt.params.empty?
        line << opt.desc unless opt.desc.empty?
        msg << line.join(" ")
      end
    end

    unless @commands.empty?
      msg << <<-COMMANDS.strip
Commands:
  #{@commands.map {|cmd| cmd.name }.join(' ')}
      COMMANDS
    end

    msg << ""
    msg.join("\n\n")
  end

  def __default__
    STDOUT.puts help_message
  end
end


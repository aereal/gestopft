# encoding: utf-8

module StringExtention
  def option?
    /^--[-a-zA-Z0-9]+$/ === self
  end

  def to_option
    (slice(0..2) == '--' ? '' : '--') + strip.gsub('_', '-')
  end
end

String.send(:include, StringExtention)


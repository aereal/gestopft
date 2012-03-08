# encoding: utf-8

require "pathname"

dir = Pathname.new(__FILE__).expand_path.parent + 'core_ext/'

dir.each_child do |entry|
  require entry.to_s
end


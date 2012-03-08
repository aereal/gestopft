# encoding: utf-8

module SymbolExtension
  def to_option
    to_s.to_option
  end
end

Symbol.send(:include, SymbolExtension)


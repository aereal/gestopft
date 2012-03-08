require "gestopft/version"
require "gestopft/core_ext"

module Gestopft
  module Constants
    class Error < ::StandardError; end
    class NotSatisfiedRequirements < Error; end
  end

  autoload :App,    'gestopft/app'
  autoload :Option, 'gestopft/option'
end


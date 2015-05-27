# encoding: utf-8

require "attestor"
require "eigindir"
require "informator"

# Shared namespace for hexx gems collections
#
module Hexx

  # Defines the base class for domain service objects
  #
  module Services

    require_relative "hexx-services/patches.rb"
    require_relative "hexx-services/translation_dsl"
    require_relative "hexx-services/execution_dsl"
    require_relative "hexx-services/dependencies_dsl"
    require_relative "hexx-services/base"

  end # module Services

end # module Hexx

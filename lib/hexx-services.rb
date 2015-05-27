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

  end # module Services

end # module Hexx

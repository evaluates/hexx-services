# encoding: utf-8

module Hexx::Services

  # The module provides features to declare dependencies of
  # service objects from other service objects.
  #
  # @example
  #   class MyService
  #     extend DSL::DependenciesDSL
  #     depends_on :get_item, GetItem
  #   end
  #
  #   service = MyService.new
  #   service.get_item             # => GetItem
  #   service.get_item = FindItem  # => FindItem
  #   service.get_item = nil       # => GetItem
  #
  module DependenciesDSL

    using Patches

    # Declare the dependency with a default value
    #
    # @param [Symbol, String] name The name of the dependency
    # @param [Class] default The default implementation for the dependency
    #
    # @raise [TypeError] if default is set to class that is not a service
    #
    # @return [Symbol] the name of the dependency
    #
    def depends_on(name, default = nil)
      if default.nil?
        attr_accessor(name)
      elsif default.kind_of_service_class?
        define_method(name) { instance_variable_get(:"@#{ name }") || default }
        attr_writer name
      else
        fail TypeError.new "The #{ default.inspect } is not a service"
      end

      self
    end

  end # module DependenciesDSL

end # module Hexx::Services

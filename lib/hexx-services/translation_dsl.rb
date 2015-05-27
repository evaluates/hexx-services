# encoding: utf-8

module Hexx::Services

  # The module provides features to do translations in the current service's
  # scope
  #
  # @example
  #   class MyService
  #     include TranslationDSL
  #   end
  #
  #   service = MyService.new
  #   service.translate :foo
  #   # => "translation missing: en.services.my_service.foo"
  #
  module TranslationDSL

    using Patches

    # Translates a name in the scope of the current service
    #
    # @overload translate(name, options)
    #   Translates a symbolic argument with given options
    #
    #   @param [Symbol] name
    #   @param [Hash] options
    #
    #   @return [String]
    #
    # @overload translate(name, *)
    #   Stringifies non-symbolic argument
    #
    #   @param [#to_s] name
    #
    #   @return [String]
    #
    def translate(name, **options)
      return name.to_s unless name.instance_of? Symbol
      I18n.t name, options.merge(scope: [:services, self.class.pathname.to_sym])
    end

  end # module TranslationDSL

end # module Hexx::Services

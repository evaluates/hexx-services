# encoding: utf-8

module Hexx::Services

  # Module contains local monkey-patches (refinements) to Ruby core classes
  #
  module Patches

    refine Class do

      # Converts the name of the class to the conventional pathname
      #
      # @example
      #   Test::MyClassName.pathname # => "test/my_class_name"
      #
      # @return [String]
      #
      def pathname
        convert = -> item { item.gsub(/([a-z])([A-Z])/, '\1_\2').downcase }
        name.split("::").map(&convert).join("/")
      end

    end # refine Class

    refine Object do

      # Checks if an object is kind of service class
      #
      # @return [Boolean]
      #
      def kind_of_service_class?
        is_a?(Class) && ancestors.include?(Hexx::Services::Base)
      end

    end # refine Object

  end # module Patches

end # module Hexx::Services

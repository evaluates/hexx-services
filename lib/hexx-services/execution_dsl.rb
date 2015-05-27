# encoding: utf-8

module Hexx::Services

  # Module ExecutionDSL includes Informator and provides [#execute] and [#call]
  # methods on top of it.
  #
  # @example
  #   class MyService
  #     include ExecutionDSL
  #
  #     def execute
  #       publish! :something
  #     end
  #   end
  #
  module ExecutionDSL
    include Informator

    # The method executes the service object catches `:published` and returns
    # its results. When nothing was published it publishes `:success` event
    # by itself.
    #
    # @return [<type>] <description>
    #
    def call
      events = Array(catch(:published) { execute })
      return events if events.first.instance_of? Event
      publish :success
    end

    # @abstract
    #
    # Defines the sequence of commands provided by the service object
    #
    # @return [undefined]
    #
    def execute
    end

  end # module DependenciesDSL

end # module Hexx::Services

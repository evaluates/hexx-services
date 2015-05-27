# encoding: utf-8

module Hexx::Services

  # The base class for domain service object
  #
  class Base

    extend  DependenciesDSL
    include Eigindir, Attestor::Validations, TranslationDSL, ExecutionDSL

    private_class_method :depends_on
    private_class_method :attribute, :attribute_reader, :attribute_writer
    private_class_method :validate, :validates

    public :subscribe, :call

    private :execute
    private :remember, :publish, :publish!
    private :attributes, :attributes=
    private :validate, :validate!, :invalid
    private :translate

  end # class Base

end # class Hexx::Services

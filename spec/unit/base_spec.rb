# encoding: utf-8

describe Hexx::Services::Base do

  subject(:service) { described_class.new }

  let(:private_class_methods) { described_class.private_methods }
  let(:private_methods)       { service.private_methods }
  let(:public_class_methods)  { described_class.methods }
  let(:public_methods)        { service.methods }

  it "implements Dependencies DSL" do
    expect(described_class).to be_kind_of Hexx::Services::DependenciesDSL
    expect(private_class_methods).to include :depends_on
  end

  it "implements Translation DSL" do
    expect(described_class).to include Hexx::Services::TranslationDSL
    expect(private_methods).to include :translate
  end

  it "implements Eigindir DSL" do
    expect(described_class).to include Eigindir

    expect(private_class_methods).to include :attribute
    expect(private_class_methods).to include :attribute_reader
    expect(private_class_methods).to include :attribute_writer

    expect(private_methods).to include :attributes
    expect(private_methods).to include :attributes=
  end

  it "implements Attestor::Validations DSL" do
    expect(described_class).to include Attestor::Validations

    expect(private_class_methods).to include :validate
    expect(private_class_methods).to include :validates

    expect(private_methods).to include :invalid
    expect(private_methods).to include :validate
    expect(private_methods).to include :validate!
  end

  it "implements Informator DSL" do
    expect(described_class).to include Informator

    expect(public_methods).to include :subscribe

    expect(private_methods).to include :remember
    expect(private_methods).to include :publish
    expect(private_methods).to include :publish!
  end

  it "implements Execution DSL" do
    expect(described_class).to include Hexx::Services::ExecutionDSL

    expect(public_methods).to include :call
    expect(private_methods).to include :execute
  end

end # describe Hexx::Services::Base

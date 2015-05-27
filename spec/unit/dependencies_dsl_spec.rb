# encoding: utf-8

describe Hexx::Services::DependenciesDSL do

  let(:klass) { Class.new { extend Hexx::Services::DependenciesDSL } }
  subject(:dependant) { klass.new }

  describe "#depends_on" do

    subject { klass.depends_on :foo, default }

    shared_examples "declaring a dependency" do
      let(:injection) { double }

      it "doesn't fail" do
        expect { subject }.not_to raise_error
      end

      it "defines the attribute" do
        subject
        expect { dependant.foo = injection }
          .to change { dependant.foo }
          .from(default)
          .to(injection)
      end

      it "resets the attribute to default" do
        subject
        dependant.foo = nil
        expect(dependant.foo).to eq default
      end

      it "returns itself" do
        expect(subject).to eq klass
      end
    end

    context "when no default is set" do

      let(:default) { nil }
      it_behaves_like "declaring a dependency"

    end # context

    context "when default is a service" do

      let(:default) { Class.new(Hexx::Services::Base) }
      it_behaves_like "declaring a dependency"

    end # context

    context "when default is not a service" do

      let(:default) { double }

      it "raises TypeError" do
        expect { subject }.to raise_error TypeError
      end

    end # context

  end # describe #depends_on

end # describe Hexx::Services::DependenciesDSL

# encoding: utf-8

describe Hexx::Services::Patches do
  using described_class

  describe "to Class" do

    subject(:klass) { Class.new }

    before { described_class::MyTestClass = klass             }
    after  { described_class.send :remove_const, :MyTestClass }

    describe "#pathname" do

      subject { klass.pathname }
      it { is_expected.to eq "hexx/services/patches/my_test_class" }

    end # describe #pathname

  end # describe Class

  describe "to Object" do

    describe "#kind_of_service_class?" do

      subject { object.kind_of_service_class? }

      context "for ancestor of Hexx::Services::Base" do

        let(:object) { Class.new(Hexx::Services::Base) }
        it { is_expected.to eql true }

      end # context

      context "for arbitrary class" do

        let(:object) { Class.new }
        it { is_expected.to eql false }

      end # context

      context "for not a class" do

        let(:object) { double }
        it { is_expected.to eql false }

      end # context

    end # describe #kind_of_service_class?

  end # describe Object

end # describe Hexx::Services::Patches

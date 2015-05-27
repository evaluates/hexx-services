# encoding: utf-8

describe Hexx::Services::TranslationDSL do

  before do
    Hexx::MyTestService = Class.new { include Hexx::Services::TranslationDSL }
  end
  after  { Hexx.send :remove_const, :MyTestService }

  subject(:translator) { Hexx::MyTestService.new }

  describe "#translate" do

    subject { translator.translate name, options }

    let(:options) { { bar: :baz } }

    context "a symbol" do

      let(:name)  { :foo }
      let(:scope) { [:services, :"hexx/my_test_service"] }

      it "translates it" do
        expect(subject)
          .to eql "translation missing: en.#{ scope.join(".") }.foo"
      end

      it "uses options" do
        expect(I18n).to receive(:t).with name, options.merge(scope: scope)
        subject
      end

    end # context

    context "non-symbol" do

      let(:name) { 1 }
      it { is_expected.to eql "1" }

    end # context

  end # describe #translate

end # describe Hexx::Services::TranslationDSL

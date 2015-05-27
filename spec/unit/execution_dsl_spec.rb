# encoding: utf-8

describe Hexx::Services::ExecutionDSL do

  subject(:executor) { Class.new { include Hexx::Services::ExecutionDSL }.new }

  it { is_expected.to be_kind_of Informator }

  describe "#execute" do

    subject { executor.execute }
    it "doesn't fail" do
      expect { subject }.not_to raise_error
    end

  end # describe #execute

  describe "#call" do

    subject { executor.call }

    let(:event) { Informator::Event.new :error }

    shared_examples "publishing result of #execute" do
      before { allow(executor).to receive(:execute) { execute } }

      it "calls #execute" do
        expect(executor).to receive :execute
        subject
      end

      it "catches exception" do
        expect { subject }.not_to raise_error
      end

      it { is_expected.to contain_exactly event }
    end

    context "when #execute returns an event" do

      let(:execute) { event }
      it_behaves_like "publishing result of #execute"

    end # context

    context "when #execute returns an array of events" do

      let(:execute) { [event] }
      it_behaves_like "publishing result of #execute"

    end # context

    context "when #execute throws :published with an event" do

      let(:execute) { throw :published, event }
      it_behaves_like "publishing result of #execute"

    end # context

    context "when #execute throws :published with array of events" do

      let(:execute) { throw :published, [event] }
      it_behaves_like "publishing result of #execute"

    end # context

    context "when #execute throws :published with no events" do

      let(:event)   { Informator::Event.new :success }
      let(:execute) { throw :published, [:event] }
      it_behaves_like "publishing result of #execute"

    end # context

    context "when #execute returns no events" do

      let(:event)   { Informator::Event.new :success }
      let(:execute) { [:event] }
      it_behaves_like "publishing result of #execute"

    end # context

  end # describe #call

end # describe Hexx::Services::ExecutionDSL

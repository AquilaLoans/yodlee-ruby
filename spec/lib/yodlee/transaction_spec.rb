require 'spec_helper'

RSpec.describe Yodlee::Transaction do
  include_context 'configure'
  include_context 'session'

  let(:from_date) { Time.parse('2010-01-01') }

  describe '.all' do
    let(:collection) { described_class.all(user_session) }

    context 'with out transactions' do
      it 'returns an empty array' do
        expect(collection).to be_an Array
        expect(collection).to be_empty
      end
    end

    context 'with transactions' do
      let(:collection) { described_class.all(user_session, from_date: from_date) }

      it 'returns an Array of Transactions' do
        expect(collection).to       be_an Array
        expect(collection.first).to be_a  described_class
      end
    end
  end

  describe '.count' do
    let(:number) { described_class.count(user_session) }

    context 'with out transactions' do
      it 'returns 0' do
        expect(number).to eq 0
      end
    end

    context 'with transactions' do
      let(:number) { described_class.count(user_session, from_date: from_date) }

      it 'returns the count' do
        expect(number).to be_a Integer
        expect(number).to be > 0
      end
    end
  end
end

RSpec.describe Yodlee::TransactionDelegator do
  include_context 'configure'
  include_context 'session'

  let(:id)        { '10676951' }
  let(:container) { 'bank' }
  let(:delegator) { described_class.new(user_session, container, id) }

  describe '#all' do
    it 'delegates' do
      expect(Yodlee::Transaction).to receive(:all).with(user_session, account_id: id, container: container)
      delegator.all
    end
  end

  describe '#count' do
    it 'delegates' do
      expect(Yodlee::Transaction).to receive(:count).with(user_session, account_id: id, container: container)
      delegator.count
    end
  end
end

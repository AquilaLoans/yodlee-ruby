require 'spec_helper'

RSpec.describe Yodlee::Account do
  include_context 'configure'
  include_context 'session'

  let(:id)        { '10676951' }
  let(:container) { 'bank' }
  let(:account)   { described_class.find(user_session, container, id) }

  describe '.all' do
    let(:collection) { described_class.all(user_session) }

    context 'with out transactions' do
      xit 'returns an empty array' do
        expect(collection).to be_an Array
        expect(collection).to be_empty
      end
    end

    context 'with accounts' do
      let(:collection) { described_class.all(user_session) }

      it 'returns an Array of Accounts' do
        expect(collection).to       be_an Array
        expect(collection.first).to be_a  described_class
      end
    end
  end

  describe '.find' do
    it 'returns an Account' do
      expect(account).to be_a described_class
    end
  end

  describe '#transactions' do
    it 'returns an TransactionDelegator' do
      expect(account.transactions).to be_a Yodlee::TransactionDelegator
    end
  end
end

RSpec.describe Yodlee::AccountDelegator do
  include_context 'configure'
  include_context 'session'

  let(:delegator) { described_class.new(user_session) }

  describe '#all' do
    it 'delegates' do
      expect(Yodlee::Account).to receive(:all).with(user_session)
      delegator.all
    end
  end

  describe '#find' do
    let(:id)        { '10676951' }
    let(:container) { 'bank' }

    it 'delegates' do
      expect(Yodlee::Account).to receive(:find).with(user_session, container, id)
      delegator.find(container, id)
    end
  end
end

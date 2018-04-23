require 'spec_helper'

RSpec.describe Yodlee::ProviderAccount do
  include_context 'configure'
  include_context 'session'

  let(:id)               { '10741073' }
  let(:account_provider) { described_class.find(user_session, id) }

  describe '.all' do
    let(:collection) { described_class.all(user_session) }

    it 'returns an Array of ProviderAccounts' do
      expect(collection).to       be_an Array
      expect(collection.first).to be_a  described_class
    end
  end

  describe '.find' do
    it 'returns a ProviderAccount' do
      expect(described_class.find(user_session, id)).to be_a described_class
    end
  end

  describe '#refresh' do
    it 'returns a ProviderAccount' do
      expect(account_provider.refresh).to be_a described_class
    end
  end

  describe '#destroy', skip: 'Breaks Future Testing' do
    it 'destroys a ProviderAccount' do
      expect(account_provider.destroy).to be nil
      expect { described_class.find(user_session, id) }.to raise_error(RestClient::BadRequest)
    end
  end

  describe '#accounts' do
    let(:collection) { account_provider.accounts }

    it 'returns an Array of Accounts' do
      expect(collection).to       be_an Array
      expect(collection.first).to be_a  Yodlee::Account
    end
  end
end

RSpec.describe Yodlee::ProviderAccountDelegator do
  include_context 'configure'
  include_context 'session'

  let(:delegator) { described_class.new(user_session) }

  describe '#all' do
    it 'delegates' do
      expect(Yodlee::ProviderAccount).to receive(:all).with(user_session)
      delegator.all
    end
  end

  describe '#find' do
    let(:id) { '10301142' }

    it 'delegates' do
      expect(Yodlee::ProviderAccount).to receive(:find).with(user_session, id)
      delegator.find(id)
    end
  end
end

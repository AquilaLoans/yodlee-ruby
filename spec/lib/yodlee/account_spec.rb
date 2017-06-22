require 'spec_helper'

RSpec.describe Yodlee::Account do
  include_context 'configure'

  let(:cobrand)  { Yodlee::Cobrand.login }
  let(:login)    { ENV.fetch('YODLEE_USER_LOGIN') }
  let(:password) { ENV.fetch('YODLEE_USER_PASSWORD') }
  let(:user)     { Yodlee::User.login(cobrand.session, login, password) }

  describe '.all' do
    let(:collection) { described_class.all(user.session) }

    it 'returns an Array of Accounts' do
      expect(collection).to       be_an Array
      expect(collection.first).to be_a  described_class
    end
  end

  describe '.find' do
    let(:id)        { '10676951' }
    let(:container) { 'bank' }
    let(:item)      { described_class.find(user.session, id, container) }

    it 'returns an Account' do
      expect(item).to be_a described_class
    end
  end
end

RSpec.describe Yodlee::AccountDelegator do
  include_context 'configure'

  let(:cobrand)  { Yodlee::Cobrand.login }
  let(:login)    { ENV.fetch('YODLEE_USER_LOGIN') }
  let(:password) { ENV.fetch('YODLEE_USER_PASSWORD') }
  let(:user)     { Yodlee::User.login(cobrand.session, login, password) }

  let(:delegator) { described_class.new(user.session) }

  describe '#all' do
    it 'delegates' do
      expect(Yodlee::Account).to receive(:all).with(user.session)
      delegator.all
    end
  end

  describe '#find' do
    let(:id)        { '10676951' }
    let(:container) { 'bank' }

    it 'delegates' do
      expect(Yodlee::Account).to receive(:find).with(user.session, id, container)
      delegator.find(id, container)
    end
  end
end

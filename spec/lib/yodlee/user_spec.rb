require 'spec_helper'

RSpec.describe Yodlee::User do
  include_context 'configure'
  include_context 'session'

  describe '.login' do
    it 'returns a User' do
      expect(user).to be_a described_class
    end

    it 'sets the session' do
      expect(user.session).to be_a Hash
      expect(user.session['cobSession']).to be_a String
      expect(user.session['userSession']).to be_a String
    end
  end

  describe '#access_tokens' do
    let(:appId)         { '10003600' }
    let(:access_tokens) { user.access_tokens(appId) }

    it 'returns an Array of AccessTokens' do
      expect(access_tokens).to      be_an Array
      expect(access_tokens.first).to be_an OpenStruct
    end
  end

  describe '#accounts' do
    it 'returns an AccountDelegator' do
      expect(user.accounts).to be_a Yodlee::AccountDelegator
    end
  end
end

RSpec.describe Yodlee::UserDelegator do
  include_context 'configure'
  include_context 'session'

  let(:delegator) { described_class.new(cobrand_session) }

  describe '#login' do
    it 'delegates' do
      expect(Yodlee::User).to receive(:login).with(cobrand_session, login, password)
      delegator.login(login, password)
    end
  end
end

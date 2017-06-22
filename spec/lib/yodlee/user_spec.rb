require 'spec_helper'

RSpec.describe Yodlee::User do
  include_context 'configure'

  let(:cobrand)  { Yodlee::Cobrand.login }
  let(:login)    { ENV.fetch('YODLEE_USER_LOGIN') }
  let(:password) { ENV.fetch('YODLEE_USER_PASSWORD') }
  let(:user)     { described_class.login(cobrand.session, login, password) }

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

  describe '#accounts' do
    it 'returns an AccountDelegator' do
      expect(user.accounts).to be_a Yodlee::AccountDelegator
    end
  end
end

RSpec.describe Yodlee::UserDelegator do
  include_context 'configure'

  let(:cobrand)   { Yodlee::Cobrand.login }
  let(:login)     { ENV.fetch('YODLEE_USER_LOGIN') }
  let(:password)  { ENV.fetch('YODLEE_USER_PASSWORD') }
  let(:delegator) { described_class.new(cobrand.session) }

  describe '#login' do
    it 'delegates' do
      expect(Yodlee::User).to receive(:login).with(cobrand.session, login, password)
      delegator.login(login, password)
    end
  end
end

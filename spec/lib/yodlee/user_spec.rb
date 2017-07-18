require 'spec_helper'

RSpec.describe Yodlee::User do
  include_context 'configure'
  include_context 'session'

  describe '.create' do
    let(:username) { 'username_04' }
    let(:password) { 'Pa$$w0rd!' }
    let(:email)    { 'example@example.com' }
    let(:user)     { described_class.create(cobrand_session, username, password, email) }

    it 'returns a User' do
      expect(user).to be_a described_class
    end

    it 'sets the session' do
      expect(user.session).to be_a Hash
      expect(user.session[:cob_session]).to be_a String
      expect(user.session[:user_session]).to be_a String
    end
  end

  describe '.login' do
    it 'returns a User' do
      expect(user).to be_a described_class
    end

    it 'sets the session' do
      expect(user.session).to be_a Hash
      expect(user.session[:cob_session]).to be_a String
      expect(user.session[:user_session]).to be_a String
    end
  end

  describe '#access_tokens' do
    let(:appId)         { '10003600' }
    let(:access_tokens) { user.access_tokens(appId) }

    it 'returns an Array of AccessTokens' do
      expect(access_tokens).to be_an Array
      expect(access_tokens.first).to be_an OpenStruct
    end
  end

  describe '#accounts' do
    it 'returns an AccountDelegator' do
      expect(user.accounts).to be_a Yodlee::AccountDelegator
    end
  end

  describe 'serialization and deserilization' do
    let(:user_json) { user.to_json }
    let(:clone)     { described_class.from_json(user_json) }

    it 'correctly recreates the same object' do
      expect(clone).to eq user
    end

    describe '#to_json' do
      it 'returns a string' do
        expect(user_json).to be_a String
      end
    end

    describe '.from_json' do
      it 'returns a User' do
        expect(clone).to be_a described_class
      end
    end
  end
end

RSpec.describe Yodlee::UserDelegator do
  include_context 'configure'
  include_context 'session'

  let(:delegator) { described_class.new(cobrand_session) }
  let(:email) { 'example@google.com' }

  describe '#create' do
    it 'delegates' do
      expect(Yodlee::User).to receive(:create).with(cobrand_session, username, password, email, {})
      delegator.create(username, password, email)
    end
  end

  describe '#login' do
    it 'delegates' do
      expect(Yodlee::User).to receive(:login).with(cobrand_session, username, password)
      delegator.login(username, password)
    end
  end
end

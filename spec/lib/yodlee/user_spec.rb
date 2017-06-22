require 'spec_helper'

RSpec.describe Yodlee::User do
  include_context 'configure'

  let(:cobrand)  { Yodlee::Cobrand.login }
  let(:login)    { ENV.fetch('YODLEE_USER_LOGIN') }
  let(:password) { ENV.fetch('YODLEE_USER_PASSWORD') }

  describe '.login' do
    let(:user) { described_class.login(cobrand, login, password) }

    it 'returns a Yodlee::User' do
      expect(user).to be_a described_class
    end

    it 'sets the session' do
      expect(user.session).to be_a Hash
      expect(user.session['cobSession']).to be_a String
      expect(user.session['userSession']).to be_a String
    end
  end
end

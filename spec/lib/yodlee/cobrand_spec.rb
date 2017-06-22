require 'spec_helper'

RSpec.describe Yodlee::Cobrand do
  include_context 'configure'
  include_context 'session'

  describe '.login' do
    it 'returns a Cobrand' do
      expect(cobrand).to be_a described_class
    end

    it 'sets the session' do
      expect(cobrand.session).to be_a Hash
      expect(cobrand.session[:cob_session]).to be_a String
    end
  end

  describe '#users' do
    it 'returns a UserDelegator' do
      expect(cobrand.users).to be_a Yodlee::UserDelegator
    end
  end
end

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

  describe '#providers' do
    it 'returns a ProviderDelegator' do
      expect(cobrand.providers).to be_a Yodlee::ProviderDelegator
    end
  end

  describe 'serialization and deserilization' do
    let(:cobrand_json) { cobrand.to_json }
    let(:clone)        { described_class.from_json(cobrand_json) }

    it 'correctly recreates the same object' do
      expect(clone).to eq cobrand
    end

    describe '#to_json' do
      it 'returns a string' do
        expect(cobrand_json).to be_a String
      end
    end

    describe '.from_json' do
      it 'returns a Cobrand' do
        expect(clone).to be_a described_class
      end
    end
  end
end

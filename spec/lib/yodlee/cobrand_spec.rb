require 'spec_helper'

RSpec.describe Yodlee::Cobrand do
  include_context 'configure'

  describe '.login' do
    let(:cobrand) { described_class.login }

    it 'returns a Yodlee::Cobrand' do
      expect(cobrand).to be_a described_class
    end

    it 'sets the session_token' do
      expect(cobrand.session_token).to be_a String
    end
  end
end

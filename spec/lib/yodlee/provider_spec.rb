require 'spec_helper'

RSpec.describe Yodlee::Provider do
  include_context 'configure'
  include_context 'session'

  let(:id)       { 3 }
  let(:provider) { described_class.find(cobrand_session, id) }

  describe '.all' do
    let(:collection) { described_class.all(cobrand_session) }

    it 'returns an array' do
      expect(collection).to     be_an Array
      expect(collection).not_to be_empty
    end

    context 'with pagination' do
      let(:page_one) { described_class.all(cobrand_session, top: 2) }
      let(:page_two) { described_class.all(cobrand_session, top: 2, skip: 2) }

      it 'returns each page' do
        expect(page_one.map(&:id)).not_to include(page_two.map(&:id))
      end
    end
  end

  describe '.find' do
    it 'returns an Provider' do
      expect(provider).to be_a described_class
    end
  end
end

RSpec.describe Yodlee::ProviderDelegator do
  include_context 'configure'
  include_context 'session'

  let(:delegator) { described_class.new(cobrand_session) }

  describe '#all' do
    it 'delegates' do
      expect(Yodlee::Provider).to receive(:all).with(cobrand_session, {})
      delegator.all
    end
  end

  describe '#find' do
    let(:id) { 3 }

    it 'delegates' do
      expect(Yodlee::Provider).to receive(:find).with(cobrand_session, id)
      delegator.find(id)
    end
  end
end

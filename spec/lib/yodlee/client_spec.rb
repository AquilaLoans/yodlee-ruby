require 'spec_helper'

RSpec.describe Yodlee::Client do
  describe '.deep_format_payload' do
    context 'with a depth of 1' do
      let(:payload) { { from_date: DateTime.parse('2017-05-25') } }
      let(:formated_payload) { described_class.deep_format_payload(payload) }

      it 'coverts keys into lower camelcase' do
        expect(formated_payload['from_date']).to be nil
        expect(formated_payload['fromDate']).not_to be nil
      end

      it 'converts dates into the YYYY-MM-DD format' do
        expect(formated_payload['fromDate']).to be_a String
        expect(formated_payload['fromDate']).to eq '2017-05-25'
      end
    end

    context 'with an array' do
      let(:payload) { { dates:[ {from_date: DateTime.parse('2017-05-25')} ] } }
      let(:formated_payload) { described_class.deep_format_payload(payload) }

      it 'coverts keys into lower camelcase' do
        expect(formated_payload['dates'].first['from_date']).to be nil
        expect(formated_payload['dates'].first['fromDate']).not_to be nil
      end

      it 'converts dates into the YYYY-MM-DD format' do
        expect(formated_payload['dates'].first['fromDate']).to be_a String
        expect(formated_payload['dates'].first['fromDate']).to eq '2017-05-25'
      end
    end

    context 'with a depth of 3' do
      let(:payload) { { transaction: { from_date: DateTime.parse('2017-05-25') } } }
      let(:formated_payload) { described_class.deep_format_payload(payload) }

      it 'coverts keys into lower camelcase' do
        expect(formated_payload['transaction']['from_date']).to be nil
        expect(formated_payload['transaction']['fromDate']).not_to be nil
      end

      it 'converts dates into the YYYY-MM-DD format' do
        expect(formated_payload['transaction']['fromDate']).to be_a String
        expect(formated_payload['transaction']['fromDate']).to eq '2017-05-25'
      end
    end
  end
end

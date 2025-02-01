# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Issues::IndexService do
  subject(:service) { described_class.result(state: state) }

  describe '.result' do
    context 'when filtering by open' do
      let(:state) { 'open' }

      it 'retrieves a list of open issues', :aggregate_failures do
        VCR.use_cassette('github/open_issues') do
          expect(service.issues.count).to eq(2)
          expect(service.issues[0].closed_at).to eq(nil)
        end
      end
    end

    context 'when filtering by closed' do
      let(:state) { 'closed' }

      it 'retrieves a list of closed issues', :aggregate_failures do
        VCR.use_cassette('github/closed_issues') do
          expect(service.issues.count).to eq(1)
          expect(service.issues[0].closed_at).not_to eq(nil)
        end
      end
    end

    context 'when filtering by all' do
      let(:state) { 'all' }

      it 'retrieves a list of all issues', :aggregate_failures do
        VCR.use_cassette('github/all_issues') do
          expect(service.issues.count).to eq(3)
        end
      end
    end
  end
end

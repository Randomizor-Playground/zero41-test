# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Issues::ShowService do
  include_context "issue setup"

  subject(:service) { described_class.result(owner: owner, repo: repo, number: number) }

  describe '.result' do
    it 'retrieves an issue', :aggregate_failures do
      VCR.use_cassette('github/single_issue') do
        expect(service.issue).not_to be_nil
        expect(service.issue.number).to eq(1)
      end
    end
  end
end

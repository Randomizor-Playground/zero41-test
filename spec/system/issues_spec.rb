# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Listing Issues', :vcr, type: :system do
  include_context "issue setup"

  around do |example|
    cassettes = [
      { name: 'github/open_issues' },
      { name: 'github/single_issue' },
      { name: 'github/issue_markdown' }
    ]

    VCR.use_cassettes cassettes do
      example.run
    end
  end

  it 'allows navigation to an issue page', :aggregate_failures do
    visit issues_path

    expect(page).to have_content('Test Open issue')
    expect(page).to have_content("#{number}")
    expect(page).to have_content("#{owner}/#{repo}")
    expect(page).to have_link('Test Open issue', href: issue_url)

    click_link 'Test Open issue'
    expect(page).to have_current_path(issue_url)
  end
end

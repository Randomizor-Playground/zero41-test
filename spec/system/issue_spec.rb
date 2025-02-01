# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Issue Details Page', :vcr, type: :system do
  include_context "issue setup"

  around do |example|
    cassettes = [
      { name: 'github/single_issue' },
      { name: 'github/issue_markdown' }
    ]

    VCR.use_cassettes cassettes do
      example.run
    end
  end

  it 'displays issue details' do
    visit issue_url

    expect(page).to have_css('div.mx-auto.bg-white.shadow-md.rounded-lg.p-6.border.border-gray-200')
    expect(page).to have_css('h1.text-3xl.font-semibold.text-gray-900', text: 'Test Open issue')
    expect(page).to have_css('span.text-gray-500.text-lg', text: '#1')
    expect(page).to have_text("Repository: #{owner}/#{repo}")
    expect(page).to have_text('Opened by randomizor')
    expect(page).to have_css('img.w-8.h-8.rounded-full')
    expect(page).to have_css('div.mt-4.leading-relaxed.space-y-4')
    expect(page).to have_link('Back to Issues', href: issues_path)
  end
end

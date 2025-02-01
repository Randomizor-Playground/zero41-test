# frozen_string_literal: true

require 'rails_helper'
require 'ostruct'

RSpec.describe Issues::DetailsComponent, type: :component do
  let(:issue) do
    OpenStruct.new(
      title: 'Test Issue',
      number: 123,
      repository_url: 'https://api.github.com/repos/user/repo',
      user: OpenStruct.new(login: 'testuser', avatar_url: 'https://example.com/avatar.png'),
      created_at: 2.hours.ago,
      body: '**Test Issue** description'
    )
  end

  around do |example|
    VCR.use_cassette("github/issue_markdown") do
      example.run
    end
  end

  subject { render_inline(described_class.new(issue: issue)) }

  describe 'Back to Issues link' do
    it 'renders the back link' do
      expect(subject.css('a').text).to include('Back to Issues')
      expect(subject.css('a').attr('href').value).to eq('/issues')
    end
  end

  describe 'issue title and number' do
    it 'displays the issue title and number' do
      expect(subject.css('h1').text).to include('Test Issue')
      expect(subject.css('h1').text).to include('#123')
    end
  end

  describe 'repository name' do
    it 'displays the repository name' do
      expect(subject.text).to include('Repository:')
      expect(subject.text).to include('user/repo')
    end
  end

  describe 'user info' do
    it 'displays the user avatar and login' do
      expect(subject.css('img').attr('src').value).to eq('https://example.com/avatar.png')
      expect(subject.text).to include('Opened by testuser')
    end

    it 'displays the issue creation time' do
      expect(subject.text).to include('about 2 hours ago')
    end
  end

  describe 'issue body' do
    it 'renders the markdown body correctly' do
      expect(subject.css("div[data-controller='code']").to_html).to include(
        '<p><strong>Test Issue</strong> description</p>'
      )
    end
  end
end

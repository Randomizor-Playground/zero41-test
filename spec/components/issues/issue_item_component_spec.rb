# frozen_string_literal: true

require 'rails_helper'
require "ostruct"

RSpec.describe Issues::ItemComponent, type: :component do
  let(:issue) do
    OpenStruct.new(
      title: 'Test Issue',
      state: issue_state,
      created_at: 2.hours.ago,
      closed_at: closed_at,
      number: 123,
      repository_url: 'https://api.github.com/repos/user/repo'
    )
  end

  let(:issue_state) { 'open' }
  let(:closed_at) { nil }

  subject { render_inline(described_class.new(issue: issue)) }

  describe 'issue link' do
    it 'renders the correct issue link' do
      expect(subject.css('a').text).to include('Test Issue')
      expect(subject.css('a').attr('href').value).to include('/user/repo/123')
    end
  end

  describe 'status display' do
    context 'when the issue is open' do
      let(:issue_state) { 'open' }

      it "displays the issue as 'opened'" do
        expect(subject.text).to include('opened')
      end
    end

    context 'when the issue is closed' do
      let(:issue_state) { 'closed' }

      it "displays the issue as 'closed'" do
        expect(subject.text).to include('closed')
      end
    end
  end

  describe 'time ago display' do
    context 'when the issue is open' do
      let(:issue_state) { 'open' }

      it 'displays the correct creation time' do
        expect(subject.text).to include('opened about 2 hours ago')
      end
    end

    context 'when the issue is closed' do
      let(:issue_state) { 'closed' }
      let(:closed_at) { 1.hour.ago }

      it 'displays the correct closed time' do
        expect(subject.text).to include('closed about 1 hour ago')
      end
    end
  end
end

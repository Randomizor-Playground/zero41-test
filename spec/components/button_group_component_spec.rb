# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ButtonGroupComponent, type: :component do
  include Rails.application.routes.url_helpers

  let(:buttons) do
    [
      { label: 'Open', path: '/issues?state=open', state: 'open' },
      { label: 'Closed', path: '/issues?state=closed', state: 'closed' },
      { label: 'All', path: '/issues?state=all', state: 'all' }
    ]
  end

  subject { render_inline(described_class.new(buttons: buttons, active_state: active_state)) }

  context "when the active state is 'open'" do
    let(:active_state) { 'open' }
    let(:html) { Capybara::Node::Simple.new(subject.to_html) }

    it 'renders all buttons' do
      expect(html).to have_link('Open', href: issues_path(state: :open))
      expect(html).to have_link('Closed', href: issues_path(state: :closed))
      expect(html).to have_link('All', href: issues_path(state: :all))
    end

    it "applies the active class to the 'Open' button" do
      expect(subject.css('a').first[:class]).to include('text-blue-700 border-blue-700')
    end

    it 'applies the inactive class to the other buttons' do
      expect(subject.css('a')[1][:class]).to include('text-gray-500 hover:text-blue-700')
      expect(subject.css('a')[2][:class]).to include('text-gray-500 hover:text-blue-700')
    end

    it 'applies correct rounding to first and last buttons' do
      expect(subject.css('a').first[:class]).to include('rounded-s-lg')
      expect(subject.css('a').last[:class]).to include('rounded-e-lg')
    end
  end

  context "when the active state is 'closed'" do
    let(:active_state) { 'closed' }

    it "applies the active class to the 'Closed' button" do
      expect(subject.css('a')[1][:class]).to include('text-blue-700 border-blue-700')
    end
  end
end

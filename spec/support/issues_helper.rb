# frozen_string_literal: true

RSpec.shared_context 'issue setup' do
  let(:owner) { 'Randomizor-Playground' }
  let(:repo) { 'zero41-test' }
  let(:number) { 1 }

  let(:issues_path) { '/issues' }
  let(:issue_url) { issue_path(number: number, owner: owner, repo: repo) }
end

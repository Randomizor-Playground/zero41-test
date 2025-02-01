# frozen_string_literal: true

class Issues::DetailsComponent < ViewComponent::Base
  include Issues::IssueHelpers

  delegate :login, :avatar_url, to: :user, allow_nil: true

  def initialize(issue:)
    @issue = issue
  end

  def html_body
    OCTOKIT_CLIENT.markdown(body).html_safe
  end
end

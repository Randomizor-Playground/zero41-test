# frozen_string_literal: true

module Issues
  class ItemComponent < ViewComponent::Base
    include Issues::IssueHelpers

    with_collection_parameter :issue

    def initialize(issue:)
      @issue = issue
    end

    def issue_link
      link_to title, issue_path(owner: owner, repo: repo, number: number),
        class: "font-medium text-blue-600 dark:text-blue-500 hover:underline"
    end

    def status
      return "opened" if open?
      "closed"
    end

    def time_text
      "#{status} #{time_ago} ago"
    end

    def time_at
      return created_at if open?
      closed_at
    end

    def time_ago
      time_ago_in_words(time_at)
    end
  end
end

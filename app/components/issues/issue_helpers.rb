module Issues
  module IssueHelpers
    extend ActiveSupport::Concern

    included do
      attr_accessor :issue
      delegate_missing_to :issue
    end

    def repo_name
      "#{owner}/#{repo}"
    end

    def open?
      state == "open"
    end

    def owner
      @owner ||= repository_url_parts[-2]
    end

    def repo
      @repo ||= repository_url_parts[-1]
    end

    def repository_url_parts
      @repository_url_parts ||= repository_url.split('/')
    end
  end
end

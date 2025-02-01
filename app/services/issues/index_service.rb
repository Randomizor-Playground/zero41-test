module Issues
  class IndexService < Actor
    input :state, default: "all"
    input :repo, default: nil

    output :issues
    output :filters

    play :set_filters,
         :fetch_issues

    def set_filters
      self.filters = { state: state }
    end

    def fetch_issues
      self.issues = OCTOKIT_CLIENT.issues(repo, **filters)
    end
  end
end

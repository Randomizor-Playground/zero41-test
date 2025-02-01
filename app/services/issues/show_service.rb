module Issues
  class ShowService < Actor
    input :repo
    input :owner
    input :number

    output :issue
    output :comments

    play :fetch_issue,
         :fetch_comments

    def fetch_issue
      self.issue = OCTOKIT_CLIENT.issue("#{owner}/#{repo}", number)
    end

    def fetch_comments
      self.comments = OCTOKIT_CLIENT.issue_comments("#{owner}/#{repo}", number)
    end
  end
end

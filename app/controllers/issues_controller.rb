class IssuesController < ApplicationController
  before_action :set_state, only: :index

  def index
    result = Issues::IndexService.result(state: @state)

    if result.success?
      @issues = result.issues
    else
      @issues = []
    end
  end

  def show
    result = Issues::ShowService.result(repo: params[:repo], owner: params[:owner], number: params[:number])

    if result.success?
      @issue = result.issue
    else
      render :missing
    end
  end

  private

  def set_state
    @state = params[:state].presence || "open"
  end
end

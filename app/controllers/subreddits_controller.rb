class SubredditsController < ApplicationController

  def index
    @subreddits = Subreddit.all.order('name asc').includes(:backgrounds)
  end

  def show
    @subreddit = Subreddit.find_by(name: params[:id])
  end

  def download
    @subreddit = Subreddit.find_by(name: params[:id])
  end

end

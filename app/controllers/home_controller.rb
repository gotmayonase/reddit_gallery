class HomeController < ApplicationController

  def index
    @subreddits = Subreddit.all.order('name asc').includes(:backgrounds)
  end

end

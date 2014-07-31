class HomeController < ApplicationController

  def index
    @subreddits = Subreddit.all.order('name asc').includes(:backgrounds)
    @backgrounds = Background.where("image_file_name is not null").includes(:subreddit).order("score desc").limit(100)
  end

end

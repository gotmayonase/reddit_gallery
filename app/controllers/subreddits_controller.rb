class SubredditsController < ApplicationController
  caches_page  :index, :show
  def index
    @subreddits = Subreddit.joins(:backgrounds).order('name asc').includes(:backgrounds)
  end

  def show
    @subreddit = Subreddit.find_by(name: "#{params[:id]}porn" )

    respond_to do |format|
      format.html
      format.zip do
        filename = File.join(Rails.root,"public","r","#{@subreddit.name}.zip")
        Zipper.zip_with_backgrounds(@subreddit.backgrounds, filename)

        send_file(filename)
      end
    end
  end

end

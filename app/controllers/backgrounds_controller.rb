class BackgroundsController < ApplicationController

  def show
  end

  def download
    @background = Background.find(params[:id])
    send_file @background.image.path
  end

end

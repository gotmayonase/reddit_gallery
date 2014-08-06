class BackgroundsController < ApplicationController

  def show
  end

  def download
    @backgrounds = Background.where(id: params[:background][:ids].split(','))
    filename = Zipper.zip_with_backgrounds(@backgrounds)
    send_file filename
  end

end

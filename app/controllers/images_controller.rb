class ImagesController < ApplicationController
  def index
    @images = Image.includes(:anime).all.order("name ASC").page params[:page]
  end

  def show
    @image = Image.find(params[:id])
    @types = @image.types.order("name ASC").page params[:page]
  end
end

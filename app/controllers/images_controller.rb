class ImagesController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Images", "/images/index"
    @images = Image.includes(:anime).all.order("name ASC").page params[:page]
  end

  def show
    add_breadcrumb "Images", "/images/index"
    @image = Image.find(params[:id])
    @types = @image.types.order("name ASC").page params[:page]
    add_breadcrumb @image.name
  end
end

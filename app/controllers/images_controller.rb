class ImagesController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Images", "/images/index"
    @images = Image.includes(:anime).includes(:types).all.order("name ASC").page params[:page]
  end

  def show
    add_breadcrumb "Images", "/images/index"
    @image = Image.includes(:anime).includes(:types).find(params[:id])
    @types = @image.types.order("name ASC").page params[:page]
    add_breadcrumb @image.name
  end
end

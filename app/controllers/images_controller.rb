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

  def new_image
    add_breadcrumb "Images", "/images/index"
    @images = Image.includes(:anime).includes(:types).where('images.created_at > ?', 3.day.ago).order("images.name ASC").page params[:page]
    add_breadcrumb "New Images"
  end

  def recent_update
    add_breadcrumb "Images", "/images/index"
    @images = Image.includes(:anime).includes(:types).where('images.created_at < ?', 3.day.ago).where('images.updated_at > ?', 3.day.ago).order("images.name ASC").page params[:page]
    add_breadcrumb "Recently Updated"
  end

  def on_sale
    add_breadcrumb "Images", "/images/index"
    @images = Image.includes(:anime).includes(:types).where("images.discount > 0").order("images.name ASC").page params[:page]
    add_breadcrumb "On Sale"
  end
end

class TypesController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Types", "/types/index"
    @types = Type.includes(:images).all.order("name ASC").page params[:page]
  end

  def show
    add_breadcrumb "Types", "/types/index"
    @type = Type.includes(:images).find(params[:id])
    @images = @type.images.order("name ASC").page params[:page]
    add_breadcrumb @type.name
  end

  def new_type
    add_breadcrumb "Types", "/types/index"
    @types = Type.includes(:images).where('types.created_at > ?', DateTime.now - 3.day).order("types.name ASC").page params[:page]
    add_breadcrumb "New Types"
  end

  def recent_update
    add_breadcrumb "Types", "/types/index"
    @types = Type.includes(:images).where('types.created_at < ?', DateTime.now - 3.day).where('types.updated_at > ?', DateTime.now - 3.day).order("types.name ASC").page params[:page]
    add_breadcrumb "Recently Updated"
  end

  def on_sale
    add_breadcrumb "Types", "/types/index"
    @types = Type.includes(:images).where("types.discount > 0").order("types.name ASC").page params[:page]
    add_breadcrumb "On Sale"
  end
end

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
end

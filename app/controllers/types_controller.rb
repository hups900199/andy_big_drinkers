class TypesController < ApplicationController
  def index
    @types = Type.includes(:images).all.order("name ASC").page params[:page]
  end

  def show
    @type = Type.includes(:images).find(params[:id])
    @images = @type.images.order("name ASC").page params[:page]
  end
end

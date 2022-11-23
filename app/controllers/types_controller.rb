class TypesController < ApplicationController
  def index
    @types = Type.includes(:images).all.order("name ASC").page params[:page]
  end

  def show
    @type = Type.find(params[:id])
  end
end

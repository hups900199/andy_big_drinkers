class AnimesController < ApplicationController
  def index
    @animes = Anime.includes(:images).all.order("name DESC").page params[:page]
  end

  def show
    @anime = Anime.find(params[:id])
  end
end

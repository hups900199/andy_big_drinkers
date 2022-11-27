class AnimesController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    @animes = Anime.includes(:images).all.order("name ASC").page params[:page]

    add_breadcrumb "Animes", "/animes/index"
  end

  def show
    @anime = Anime.includes(:images).find(params[:id])

    add_breadcrumb "Animes", "/animes/index"
    add_breadcrumb @anime.name
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    search_anime     = params[:anime]
    #debugger.log(wildcard_search)

    if search_anime != ""
      @totals = Anime.where("name LIKE ? OR description LIKE ?", wildcard_search, wildcard_search).where(id: search_anime)
      @animes = Anime.where("name LIKE ? OR description LIKE ?", wildcard_search, wildcard_search).where(id: search_anime).order("name ASC").page params[:page]
    elsif wildcard_search != "%%"
      @totals = Anime.where("name LIKE ? OR description LIKE ?", wildcard_search, wildcard_search)
      @animes = Anime.where("name LIKE ? OR description LIKE ?", wildcard_search, wildcard_search).order("name ASC").page params[:page]
    else
      @totals = Anime.all
      @animes = Anime.all.order("name ASC").page params[:page]
    end

    add_breadcrumb "Animes", "/animes/index"
  end
end

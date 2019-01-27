class GenresController < ApplicationController

  def index
    @genres = Genre.all
    
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
       @genre.movies.first.update(user_id: current_user.id)
    # binding.pry
    if @genre.save
      flash[:success] = "#{@genre.name} added"
      redirect_to genre_path(@genre)
    else
      flash.now[:error] = "Please enter a genre"
      render :new
    end
  end

  def show
    @genre = Genre.find(params[:id])

    respond_to do |format|
      format.html {render :show }
      format.json { render json: @genre}
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    if @genre.update(genre_params)
      flash[:notice] = "#{@genre.name} was updated"
    end
  end


  private

    def genre_params
      params.require(:genre).permit(:name, :movies_attributes => [:id, :title, :year, :description, :director ])
    end


end
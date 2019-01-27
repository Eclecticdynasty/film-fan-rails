class CommentsController < ApplicationController
  before_action :set_movie

  def index
    @movie = Movie.find(params[:movie_id])
    @comments = @movie.comments.all

   respond_to do |format|
    format.html { render :index }
    format.json { render json: @comments}

     
   end
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      

      respond_to do |format|
        format.html do
          flash[:success] = 'Comment posted!'
          redirect_to movie_path(@movie)
      end
      format.json do
        render :json => @comment
    end
  end
    else
      flash[:notice] = "Please try again -- Comment must be at least 10 characters."
      redirect_to movie_path(@movie)
    end


  end

  def show
    render 'comments/index', :layout => false
  end

  def update
    @comment = @movie.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to movie_path(@movie), flash: {success: "comment was updated"}
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.find(params[:id])
    @comment.destroy

    redirect_to movie_path(@movie)
  end



  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :movie_id)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
    
  end
  
end
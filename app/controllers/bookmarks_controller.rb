class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
  end

  def create
      @topic = Topic.find(params[:topic_id])
      @bookmark = @topic.bookmarks.build(bookmark_params)
      @bookmark.user = current_user
      authorize @bookmark
      if @bookmark.save
        flash[:notice] = "Bookmark saved."
        redirect_to [@topic, @bookmark]
      else
        flash.now[:alert] = "There was an error saving the bookmark. Please try again."
        render :new
      end
    end

  def edit
    @topic = Topic.find(params[:id])
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @bookmark = Bookmark.find(params[:id])
    @bookmark.assign_attributes(bookmark_params)
    authorize @bookmark
    if @bookmark.save
      flash[:notice] = "Bookmark updated."
      redirect_to [@topic]
    else
      flash.now[:alert] = "There was an error editing your bookmark. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    if @bookmark.destroy
      flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully."
      redirect_to [@topic]
    else
      flash[:notice] = "There was an error deleting the bookmark."
      redirect_to [@topic]
    end
  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:url)
  end

end

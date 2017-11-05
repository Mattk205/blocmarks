class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new

  end

  def create
   @topic = Topic.new(topic_params)
   @topic.user = current_user

    if @topic.save
      redirect_to root_path, notice: "Topic was saved successfully."
    else
      flash.now[:alert] = "Error creating topic. Please try again."
      render :new
    end
  end

  def edit
  end

  private
  def topic_params
    params.require(:topic).permit(:title)
  end
end

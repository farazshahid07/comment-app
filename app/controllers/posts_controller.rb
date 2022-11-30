class PostsController < ApplicationController
  # before_action :find_post, only: [:edit, :update, :destroy]

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)
    if @post.save
      redirect_to @user
    else
      flash.now[:error] = "Could not save post"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy

    redirect_to @user
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
    def find_post 
      @post = post.find(params[:id])
    end
end

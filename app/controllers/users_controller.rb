class UsersController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.all
  end

  def show
    # @post = Post.find(params[:id])
    # @commentable = @post
    # @comment = Comment.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      flash.now[:error] = "Could not save user"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    
    if @user.update(user_params)
      redirect_to @user, :notice => 'User has been updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end
    def find_article 
      @user = User.find(params[:id])
    end
end

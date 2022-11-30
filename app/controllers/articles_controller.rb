class ArticlesController < ApplicationController
  before_action :find_user, only: [:new, :create, :destroy]

  def new
    @article = @user.articles.new
  end
  
  def create
    @article = @user.articles.create(article_params)
    if @article.save
      redirect_to @user
    else
      flash.now[:error] = "Could not save article"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @article = @user.articles.find(params[:id])
    @article.destroy

    redirect_to @user
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
    def find_user 
      @user = User.find(params[:user_id])
    end
end

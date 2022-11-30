class CommentsController < ApplicationController

  before_action :set_commentable

  def new
    # @user = User.find(params[:user_id])
    # @post = @user.posts.find(params[:id])
    # @comment = @user.posts.comment.new
    @comment = Comment.new
  end
  
  def create
    # @user = User.find(params[:user_id])
    # @post = @user.posts.find(params[:id])
    # @comment = @user.posts.comment.create(comment_params)
    # if @comment.save
    #   redirect_to @user
    # else
    #   flash.now[:error] = "Could not save post"
    #   render :new, status: :unprocessable_entity
    # end
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      redirect_to @commentable, notice: "Comment created"
    else
      render :new
    end
  end

  def destroy
    # @user = User.find(params[:user_id])
    # @post = @user.posts.find(params[:id])
    # @comment = @user.posts.comment.find(params[:id])
    # @comment.destroy

    # redirect_to @user
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to @commentable, notice: "Comment deleted"
    else
      redirect_to @commentable, alert: "Something went wrong"
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commentor, :body)
    end

    def set_commentable
      if params[:user_id].present?
        @commentable = User.find_by_id(params[:user_id])
      elsif params[:post_id].present?
        @commentable = Post.find_by_id(params[:post_id])
      end
    end
end

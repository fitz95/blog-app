class CommentsController < ApplicationController
  before_action :set_user, only: %i[index show create]
  before_action :set_post, only: %i[index show new create edit update destroy]
  def new
  end

  def create
    @comment = @user.comments.create(comment_params)
    @comment.post_id = @post.id

    if @comment.save
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

end

class LikesController < ApplicationController
  before_action :set_user, only: %i[index show create new]
  before_action :set_post, only: %i[index show new create edit update destroy]
  
  def new
  end

  def create
    @like = @post.likes.new
    @like.author = @user
    if @like.save
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  private 
  
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

end

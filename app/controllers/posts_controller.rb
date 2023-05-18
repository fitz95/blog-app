class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.most_three_recent_posts
  end

  def show
    @post = Post.includes(comments: :author).find(params[:id])
  end

  def new
    @post = @current_user.posts.new
  end

  def create
    @user = @current_user
    @post = @current_user.posts.create(post_params)

    if @post.save
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

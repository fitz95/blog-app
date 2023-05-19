class PostsController < ApplicationController
  before_action :set_user, only: %i[index show new]
  def index
    @posts = @user.most_three_recent_posts
  end

  def show
    @post = Post.includes(comments: :author).find(params[:id])
  end

  def new
    @post = @user.posts.new
  end

  def create
    @post = @user.posts.create(post_params)

    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to user_post_path(@user, @post)
    else
      flash[:alert] = "Post couldn't be created"
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
  def set_user
    @user = User.find(params[:user_id])
  end
end

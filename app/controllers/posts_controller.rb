class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_post, except: [:index, :create, :new]
  after_action :trace_post_view, only: [:show]

  def index
    if current_user
      @posts = current_user.posts
    else
      @posts = Post.all
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

    def set_post
      @post = Post.find_by(slug: params[:slug])
    end

    def post_params
      params.require(:post).permit(:title, :body_markdown, :category, :published_at)
    end

    def trace_post_view
      @post.increment!(:views)
    end
end

class BlogPostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # this helper method can replace the .find()
  before_action :set_blog_post, except: [:index, :new, :create] # only: [:show, :edit, :update, :destroy]

  def index
    # look up all posts and save to an instance variable
    # rails knows to share these with the erb templates
    @blog_posts = user_signed_in? ? BlogPost.sorted : BlogPost.published.sorted
  end

  def show
  end

  def new
    # creates a blog_post in memory, but not the database
    @blog_post = BlogPost.new
  end

  def create
    # rails does not allow you to pass params directly to the model for security reasons
    # @blog_post = BlogPost.new(params[:blog_post])
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      # status gives us the correct response code in our http request
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :published_at)
  end

  def set_blog_post
    @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    # this is a helper method that equates to "/"
    redirect_to root_path
  end
end
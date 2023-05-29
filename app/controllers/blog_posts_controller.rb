class BlogPostsController < ApplicationController
  def index
    # look up all posts and save to an instance variable
    # rails knows to share these with the erb templates
    @blog_posts = BlogPost.all
  end

  def show
    # params comes from ApplicationController
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    # this is a helper method that equates to "/"
    redirect_to root_path
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

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end
end
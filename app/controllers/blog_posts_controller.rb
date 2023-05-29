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
end
class BlogPostsController < ApplicationController
  def index
    # look up all posts and save to an instance variable
    # rails knows to share these with the erb templates
    @blog_posts = BlogPost.all
  end
end
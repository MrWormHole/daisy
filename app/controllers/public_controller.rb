class PublicController < ApplicationController

  before_action :shuffle_posts, :only => [:home]

  def home
    # @popular_posts = Post.visible.popular_first
    # @recent_posts = Post.visible.newest_first
  end

  private

  def shuffle_posts
    @posts = Post.visible.sorted
    @posts = @posts.shuffle(random: Random.new(1))
  end

end

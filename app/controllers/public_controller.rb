class PublicController < ApplicationController

  before_action :shuffle_posts, :only => [:home]
  # helper_method :get_info
  helper_method :estimate_past_time

  def home
    # @popular_posts = Post.visible.popular_first
    # @recent_posts = Post.visible.newest_first
    shuffle_posts
    calc_rows
  end

  private

  def shuffle_posts
    @posts = Post.visible.sorted
    @posts = @posts.shuffle(random: Random.new(1))
  end

  def calc_rows
    puts "#{@posts.length} Total Posts Found"
    @rows = @posts.length / 3
    @remainder = @posts.length % 3
  end

  def estimate_past_time(post)
    estimated_past_time = ((Time.new - post.created_at) / 1.minute).round
    if estimated_past_time >= 1 && estimated_past_time <= 60
      return "Posted #{estimated_past_time} minute ago" if estimated_past_time == 1
      return "Posted #{estimated_past_time} minutes ago"
    elsif estimated_past_time < 1
      return "Posted less than a minute ago"
    end

    estimated_past_time = ((Time.new - post.created_at) / 1.hour).round
    if estimated_past_time >= 1 && estimated_past_time <= 24
      return "Posted #{estimated_past_time} hour ago" if estimated_past_time == 1
      return "Posted #{estimated_past_time} hours ago"
    end

    estimated_past_time = ((Time.new - post.created_at) / 1.day).round
    if estimated_past_time >= 1
      return "Posted #{estimated_past_time} day ago" if estimated_past_time == 1
      return "Posted #{estimated_past_time} days ago"
    end
  end

end

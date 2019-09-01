class PublicController < ApplicationController

  before_action :shuffle_posts, :only => [:home]
  helper_method :get_info_then_pop
  helper_method :get_test

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
    puts "#{@rows} Row Count"
    @remainder = @posts.length % 3
    puts "#{@remainder} Remainder Count"
  end

  # change it to a helper method
  # not good for querying. Optimize this
  def get_info_then_pop
    post = @posts.last
    @posts.pop
    estimated_past_time = ((Time.new - post.created_at) / 1.day).round
    # puts estimated_past_time
    # Maybe reverse the decision making? this doesn't seem too good
    if estimated_past_time < 2
      # handle hours and minutes if this is 0
      return "Posted #{estimated_past_time} day ago"
    end
    return "Posted #{estimated_past_time} days ago"
  end

  def get_test
    post = @posts.last
    return post.location
  end

end

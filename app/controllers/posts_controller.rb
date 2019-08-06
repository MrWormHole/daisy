class PostsController < ApplicationController

  before_action :authenticate_user!,:except => [:show]
  before_action :prevent_user_forgery, :only => [:edit,:update,:delete,:destroy]
  before_action :inc_visitor_count, :only => [:show]

  def index
    @my_posts = current_user.posts
  end

  # Display a single record
  def show
    # @post = Post.find(params[:id])
    # inc_visitor_count(@posts)
  end

  # Display a new record form
  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = "Success! Post created"
      redirect_to @post
    else
      render('new')
    end
  end

  # Display an edit record form
  def edit
    #@post = Post.find(params[:id])
    if !@authoriy_provided
      redirect_to :controller => 'public',:action => 'home'
    end
  end

  def update
      #@post = Post.find(params[:id])
      if @post.update(post_params)
        flash[:notice] = "Success! Post updated"
        redirect_to @post
      else
        render('edit')
      end
  end

  # Display a delete record form
  def delete
    #@post = Post.find(params[:id])
    if !@authoriy_provided
      redirect_to :controller => 'public',:action => 'home'
    end
  end

  def destroy
      # @post = Post.find(params[id])
      @post.destroy
      flash[:notice] = "Success! Post destroyed"
      redirect_to :controller => 'public', :action => 'home'
  end

 # # might be helper in the future
 # def posts_calculate_rows
 #   value = Post.visible.sorted.count
 #   row_count = value / 4
 #   extra = value % 4
 #   return [row_count,extra]
 # end

  private

  def post_params
    params.require(:post).permit(:header,:content,:name,:location,:phone_number)
  end

  def prevent_user_forgery
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      @authoriy_provided = false
      redirect_to :controller => 'public', :action => 'home'
    else
      @authoriy_provided = true
    end
  end

  def inc_visitor_count
    @post = Post.find(params[:id])

    if params[:action] == 'show' && params[:controller] == 'posts'
      @post.visitor_count += 1
      @post.save
    end
  end

end

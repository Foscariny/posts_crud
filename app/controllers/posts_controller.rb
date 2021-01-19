class PostsController < ApplicationController
  
  before_action :set_post, only: [:show, :update, :destroy, :edit]
  impressionist :actions=>[:index, :show]
  ONLY_LETTERS_REGEX = /^[\w\s.-]+$/i

  # GET /posts
  def index
    @posts = Post.all().order("rating")
    
    respond_to do |format|
    format.html { render :index}
    format.json { render json: @posts}
    end
  end

  def search
    @search_term = params[:search]
    @posts = Post.where("title LIKE lower(?)", "%#{@search_term}%")
    render :index
  end

  def filter
    respond_to do |format|

      if params[:filter].blank?
        redirect_to posts_path
      elsif params[:filter] == 'good'
        @posts = Post.good.order("rating")
        format.html { render :index}
        format.json { render json: @posts}
      elsif params[:filter] == 'bad'
        @posts = Post.bad.order("rating")
        format.html { render :index}
        format.json { render json: @posts}
      elsif params[:filter] == 'my-ratings'
        @posts = Post.your_ratings(current_user.id).order("rating")
        format.html { render :index}
        format.json { render json: @posts}
      else
        @posts = Post.all().order("rating")
        format.html { redirect_to posts_path}
        format.json { render json: @posts}
      end
    end
  end

  # GET /posts/:id
  def show
    respond_to do |format|
      impressionist(@post)
      format.html { render :show}
      format.json { render json: @post}
      end
    end
  
  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      
      if @post.title.blank? || @post.description.blank? || !@post.title.match(ONLY_LETTERS_REGEX)
        format.html { render :new, notice: 'Incorrect fields are not accepted.'  }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      elsif @post.save
        format.json { render json: @post, status: :created }
        format.html { redirect_to @post, notice: 'Test was successfully created.' }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.html { render :new}
      end
    end
  end

  # PATCH/PUT /posts/:id
  def update
    respond_to do |format|
      if post_params[:title].blank? || post_params[:description].blank? || !@post.update(post_params)
        format.html { render :edit, notice: 'Invalid fields, please fill it correctly'  }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok}
      end
    end
  end
   
  # DELETE /posts/:id
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def new
    @post = Post.new
  end

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def post_params
  params.require(:post).permit(:title, :description, :rating, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def render_not_found(exception)
    render json: { error: exception.message }, status: :not_found
    end
  
end

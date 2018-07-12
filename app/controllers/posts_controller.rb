class PostsController < ApplicationController
  # what can be set before page is run
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  # posts is plural bc we want active record to put all posts in one variable
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  # makes show view available; no parameters set
  def show
    @comment = Comment.new
  end

  # GET /posts/new
  # creates one new post; global variable is singular
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  # no variables passed but edit is available
  def edit
  end

  # POST /posts
  # POST /posts.json
  # no create page, so defined a method to take param from page, looks to see if there is a post param variable then processes. If saving, format html and redirect to post
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  # similar to create but uses update active record
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  # takes post, finds id, and removes, redirects to list of all posts
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

# any method here not accessible outside of this controller; only allows certain parameters to be passed in as variables (method 2 below); set_post finding record with the id of the post
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :author, :blog_entry, :created_at, :user_id)
    end
end

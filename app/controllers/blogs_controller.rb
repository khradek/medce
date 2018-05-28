class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit] 
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :author_user, only: [:new, :edit, :update, :destroy]
  before_filter :authorize_admin, only: [:index, :show, :update, :destroy, :edit, :new] #remove once section ready to go live


  def index
    @q = Blog.search(params[:q])
    @blogs = @q.result(distinct: true).where('published = ?', true).order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
    @recent_blogs = Blog.where('published = ?', true).limit(5).order('id DESC')
    @recent_articles = Article.where('published = ?', true).limit(5).order('id DESC')
  end

  def show
    @q = Blog.search(params[:q])
    @recent_blogs = Blog.where('published = ?', true).limit(5).order('id desc')
    @recent_articles = Article.where('published = ?', true).limit(5).order('id DESC')
  end

  def new
    @blog = current_user.blogs.build
  end

  def edit
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'The blog post was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'The blog post was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'The blog post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def correct_user
      redirect_to root_path, notice: "You can only edit blogs that you authored." if @blog.user != current_user   
    end

    def author_user
      redirect_to root_path, notice: "You do not have the needed permission to create a blog post." unless current_user.author   
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :body, :author, :user_id, :category, :published, :spotlight, :image)
    end
end

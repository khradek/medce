class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit] 
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :author_user, only: [:new, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @q = Article.search(params[:q])
    @articles = @q.result(distinct: true).where('published = ?', true).where('external = ?', false ).order('created_at DESC').paginate(:page => params['articles'], :per_page => 5)
    @web_articles = @q.result(distinct: true).where('published = ?', true).where('external = ?', true ).order('created_at DESC').paginate(:page => params['web_articles'], :per_page => 5)
    @recent_articles = Article.limit(5).order('id desc')
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @q = Article.search(params[:q])
    @recent_articles = Article.limit(5).order('id desc')
  end

  # GET /articles/new
  def new
    @article = current_user.articles.build
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = current_user

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'The article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'The article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'The article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def correct_user
      redirect_to root_path, notice: "You can only edit classes that you authored." if @article.user != current_user   
    end

    def author_user
      redirect_to root_path, notice: "You do not have the needed permission to create an article." unless current_user.author   
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :image, :remove_image, :link, :external, :author, :user_id, :category, :published, :spotlight)
    end
end

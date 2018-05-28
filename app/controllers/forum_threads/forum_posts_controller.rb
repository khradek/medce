class ForumThreads::ForumPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_forum_thread
  before_action :set_forum_post, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_filter :authorize_admin, only: [:index, :show, :update, :destroy, :edit, :new] #remove once section ready to go live

  def create
    @forum_post = @forum_thread.forum_posts.new forum_post_params
    @forum_post.user = current_user

    if @forum_post.save
      #@forum_post.send_notifications!
      redirect_to forum_thread_path(@forum_thread, anchor: "forum_post_#{@forum_post.id}"), notice: "Successfully posted!"
    else
      redirect_to @forum_thread, alert: "Unable to save your post"
    end
  end

  def edit
    @forum_thread = ForumThread.find(params[:forum_thread_id])
  end

  def update
    @forum_thread = ForumThread.find(params[:forum_thread_id])
    @forum_post.update(forum_post_params)
    
    respond_to do |format|
      if @forum_post.update(forum_post_params)
        format.html { redirect_to @forum_thread, notice: 'The post was successfully updated.' }
        format.json { render :show, status: :ok, location: @forum_thread }
        format.js 
      else
        format.html { render :edit }
        format.json { render json: @forum_thread.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  private

    def set_forum_post
      @forum_post = ForumPost.find(params[:id])
    end

    def set_forum_thread
      @forum_thread = ForumThread.find(params[:forum_thread_id])
    end

    def forum_post_params
      params.require(:forum_post).permit(:body)
    end

      def correct_user
      redirect_to root_path, notice: "Not authorized" if @forum_post.user != current_user   
    end
end
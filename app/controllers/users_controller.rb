class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @courses = @user.courses.order("title").paginate(:page => params[:page], :per_page => 5)
  end

end

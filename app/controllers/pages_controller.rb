class PagesController < ApplicationController

  def masquerade
    if current_user.admin?
      @users = User.all
    end
  end

end
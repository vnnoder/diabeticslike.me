class HomeController < ApplicationController
  after_filter :remove_new_user_session

  def index
    if signed_in?
      if current_user.sign_in_count < 1
        redirect_to edit_profile_url
      else
        redirect_to profile_url
      end
    else
      redirect_to new_user_session_path
    end
  end

  private
  def remove_new_user_session
    if session[:new_user]
      session[:new_user] = false
    end
  end
end

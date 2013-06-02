class UsersController < ApplicationController

  def update_phonenumber
    @user = current_user
    @success = @user.update_attributes(params[:user])
  end

  def glucose_data
    #TODO update date to recent date
    data = current_user.get_glucose_data('2011-06-23 16:00:00')
    render :json => data
  end


end

class ProfileController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user
    @average = current_user.average
    @variance = current_user.variance
  end


  def edit
    @user = current_user
  end

  def update
    if current_user.update_attributes(params[:user])
      render :text => 'success'
    else
      render :text => 'failure', :status => 400
    end
  end

  def single_update
    current_user.update_attribute(params[:name], params[:value])
    render :text => 'success'
  end

  def public
    @user = User.find params[:id]
    @average = @user.average
    @variance = @user.variance
    render :show
  end

end

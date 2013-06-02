class AuthenticationsController < ApplicationController

  def create
    omniauth = request.env['omniauth.auth']
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = 'Signed in successfully.'
      sign_in_and_redirect(:user, authentication.user)
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = 'Signed in successfully.'
        session[:new_user]  = true
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        flash[:error] = 'log in failure'
        redirect_to root_url
      end
    end
  end


  def auth_upload_yt

    if params[:error].present?
      flash[:error] = params[:error]
      redirect_to redirect_url
    else
      access_token = get_access_token
      redirect_to redirect_url(access_token)
    end
  end

  protected
  def redirect_url(access_token=nil)
    case
      when params[:state] =~ /experience$/i
        my_experience_videos_url(params[:state].to_i, :access_token => access_token)
      else
        verification_my_profile_url(:access_token => access_token)
    end
  end

  def get_access_token
    data = {
        code: params[:code],
        client_id: '771587125701.apps.googleusercontent.com',
        client_secret: 'XPSLHOv8mGi-Mw4cTuvBcM9o',
        redirect_uri: upload_yt_auth_url,
        grant_type: 'authorization_code'
    }
    res = HTTParty.post('https://accounts.google.com/o/oauth2/token',
                        {
                            :headers => {'Content-Type' => 'application/x-www-form-urlencoded'},
                            :body => data
                        })
    res['access_token']
  end
end

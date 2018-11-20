class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
    end
    redirect_to '/'
  end

  def localized
    # Just save the current locale in the session and redirect to the unscoped path as before
    session[:omniauth_login_locale] = I18n.locale
    redirect_to user_omniauth_authorize_path(params[:provider])
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery except: [:index, :show, :fullsize]
  before_action :authenticate_user!, except: [:index, :show, :fullsize] 

  def require_login

  end

  #def after_sign_in_path_for(_resource)
  #  wallpapers_path
  #end

  #def after_sign_out_path_for(resource_or_scope)
  #  request.referrer
  #end
end

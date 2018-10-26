class ApplicationController < ActionController::Base
  before_action :authenticate_user!|| :authenticate_admin_user!, except: [ :index ]


  #def require_login
  #
  #end

  #def after_sign_in_path_for(_resource)
  #  wallpapers_path
  #end

  #def after_sign_out_path_for(resource_or_scope)
  #  request.referrer
  #end
end

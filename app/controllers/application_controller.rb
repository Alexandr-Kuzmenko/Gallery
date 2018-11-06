class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index], unless: :admin_user_signed_in?

  after_action :record_navigation, only: [:index, :new, :show, :edit]
  #before_action :record_signing_out, only: :destroy, if: { controller_name: :sessions_controller }


  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      @current_user = current_user
      record_signing_in
      root_path
    elsif resource_or_scope.is_a?(AdminUser)
      admin_root_path
    end
  end

  def record_signing_out
    common_activity_line
    @activity.action = 'sign out'
    @activity.save
    destroy_user_session_path
  end

    #def after_sign_out_path_for(_resource_or_scope)
  #end
  private

  def record_signing_in
    common_activity_line
    @activity.action = 'sign in'
    @activity.save
  end

  def record_navigation
    if @current_user && location_has_changed
      common_activity_line
      @activity.action = 'navigation'
      @activity.save
    end
  end

  def record_changing
    if @current_user
      common_activity_line
      @activity.action = @record_action
      @activity.save
    end
  end

  def common_activity_line
    @activity = @current_user.activities.new
    @activity.url_page = request.referrer
  end

  def location_has_changed
    @current_user.activities.last.url_page != request.referrer if @current_user
  end
end

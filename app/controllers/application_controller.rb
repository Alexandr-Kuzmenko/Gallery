class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index], unless: :admin_user_signed_in?
  before_action :record_activity, only: [:record_navigation]

  after_action :record_activity, only: [:index, :show, :edit, :new]
  after_action :record_changing, only: [:create, :update, :destroy]

  def record_activity
    if current_admin_user || current_user
      record_navigation unless request.referrer == @current_referrer
    end
  end

  #def record_authorization
  #  @activity = Activity.new
  #  real_user
  #  #__method__.to_s == 'destroy' ? @activity.action = 'Sign out' : @activity.action = 'Sign in'
  #  @activity.action = 'Signing'
  #  @activity.url_page = request.referrer
  #  @activity.save
  #end
  #def after_sign_in_path_for(_resource)
  #end

  #def after_sign_out_path_for(_resource_or_scope)
  #end
  private

  def real_user
    if current_admin_user
      @activity.user_type = 'AdminUser'
      @activity.user_id = current_admin_user.id
      @activity.user_email = current_admin_user.email
    elsif current_user
      @activity.user_type = 'User'
      @activity.user_id = current_user.id
      @activity.user_email = current_user.email
    else
      @activity.user_type = 'Unlogged'
      @activity.user_id = 0
      @activity.user_email = ""
    end
  end

  def record_navigation
    @activity = Activity.new
    real_user
    @activity.action = 'navigation'
    @activity.url_page = request.referrer
    @activity.save
    @current_referrer = @activity.url_page
  end

  def record_changing
    @activity = Activity.new
    real_user
    @activity.action = @record_action
    @activity.url_page = request.referrer
    @activity.save
  end


end

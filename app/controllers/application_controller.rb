class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_user!, except: [:index], unless: :admin_user_signed_in?
  after_action :record_navigation, only: [:index, :new, :show, :edit]
  before_action only: :destroy, if: :sessions_controller? do
    record_signing("sign out")
  end
  after_action only: :create, if: :sessions_controller? do
    record_signing("sign in")
  end

  private

  def record_signing(param)
    if current_user
      activity = current_user.activities.new(url_page: request.referrer, action_type: param)
      activity.save
    end
  end

  def record_navigation
    if current_user && location_has_changed
      activity = current_user.activities.new(url_page: request.referrer, action_type: 'navigation')
      activity.save
    end
  end

  def record_changing
    if current_user
      activity = current_user.activities.new(url_page: request.referrer, action_type: @record_action)
      activity.save
    end
  end

  def location_has_changed
    current_user.activities.last.url_page != request.referrer if current_user
  end

  def sessions_controller?
    controller_name.eql?('sessions')
  end
end

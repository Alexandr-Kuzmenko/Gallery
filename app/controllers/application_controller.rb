class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :top_categories, :last_comments
  before_action :set_locale
  before_action :authenticate_user!, except: [:index], unless: :admin_user_signed_in?

  # Tracking user actions part:
  after_action :record_navigation, only: [:index, :new, :show, :edit]

  before_action only: :destroy, if: :sessions_controller? do
    record_signing('sign out')
  end

  after_action only: :create, if: :sessions_controller? do
    record_signing('sign in')
  end

  after_action only: :create, if: :registrations_controller_and_user? do
    UserMailer.with(user: current_user).greetings_email.deliver_later
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.default_locale = params[:locale] || I18n.default_locale
  end

  private

  def record_signing(param)
    current_user.activities.create(url_page: request.referrer, action_type: param) if current_user
  end

  def record_navigation
    current_user.activities.create(url_page: request.referrer, action_type: 'navigation') if current_user && location_has_changed
  end

  def record_changing
    current_user.activities.create(url_page: request.referrer, action_type: @record_action) if current_user
  end

  def location_has_changed
    current_user.activities.last.url_page != request.referrer if current_user.activities.first
  end

  def sessions_controller?
    controller_name.eql?('sessions')
  end

  def registrations_controller_and_user?
    controller_name.eql?('registrations') && current_user
  end

  def top_categories
    @top_categories = Category.limit(5).order('wallpapers_count desc').to_a
    @bg_wallpapers = []
    @top_categories.each do |ctg|
      @bg_wallpapers << ctg.wallpapers.limit(2).order('likes_count desc').to_a
    end
    @bg_wallpapers = @bg_wallpapers.flatten
  end

  def last_comments
    @last_comments = Comment.limit(5).order('created_at desc')
  end
  # def extract_locale_from_accept_language_header
  #   request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  # end
end

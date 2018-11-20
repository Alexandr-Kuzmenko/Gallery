class UserMailer < ApplicationMailer
  default from: 'gallery_site_emailer@example.com'

  def greetings_email
    @user = params[:user]
    mail(to: @user.email, subject: 'First welcome mail')
  end

  def subscribe_created_email
    @user = params[:user]
    @category = params[:category]
    mail(to: @user.email, subject: 'Subscription have been added')
  end

  def new_wallpaper_at_subs_category(email)
    @category = params[:category]
    mail(to: email, subject: 'New content on your subscription')
  end
end

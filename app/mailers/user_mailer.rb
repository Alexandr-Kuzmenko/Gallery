class UserMailer < ApplicationMailer
  default from: 'gallery_site_emailer@example.com'

  def greetings_email
    @user = params[:user]
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def subscribe_created_email
    @user = params[:user]
    @category = params[:category]
    mail(to: @user.email, subject: 'Subscription have been added')
  end

  # new content for subscribed categories
  def list_for_new_wallpapers_recipients
    @category = params[:category]
    emails = @category.users.pluck(:email)
    until emails == [] do
      email = emails.shift
      UserMailer.with(category: @category).new_wallpaper_at_subs_category_email(email).deliver_now
    end
  end

  def new_wallpaper_at_subs_category_email(email)
    @category = params[:category]
    mail(to: email, subject: 'New content on your subscription')
  end
  # end of methods for subscribed categories

end

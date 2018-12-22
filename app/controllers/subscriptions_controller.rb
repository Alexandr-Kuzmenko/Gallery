class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @category = Category.friendly.find(params[:category_id])
    check_subscription ? unset_subscription : set_subscription
    redirect_back fallback_location: category_url(@category)
  end

  private

  # methods for the button: "subscribe"

  def set_subscription
    @subscription = current_user.subscriptions.create(category: @category)
    UserMailer.with(user: current_user, category: @category).subscribe_created_email.deliver_now
  end

  def unset_subscription
    @subscription.destroy
  end

  def check_subscription
    @subscription = current_user.subscriptions.find_by category: @category
  end

  # end of methods for the button: "subscribe"
end

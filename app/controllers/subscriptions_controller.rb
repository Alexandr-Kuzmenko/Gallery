class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @category = Category.find(params[:category_id])
    check_subscription ? unset_subscription : set_subscription
    current_admin_user ? redirect_to(admin_category_path(@category)) : redirect_to(category_path(@category))
  end

  private

  # methods for the button: "subscribe"

  def set_subscription
    @subscription = current_user.subscriptions.create(category: @category)
  end

  def unset_subscription
    @subscription.destroy
  end

  def check_subscription
    @subscription = current_user.subscriptions.find_by category: @category
  end

  # end of methods for the button: "subscribe"
end

class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_parent_category, only: [:new]

  def new
    check_subscription ? unset_subscription : set_subscription
    redirection
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

  def redirection
    current_admin_user ? redirect_to(admin_category_path(@category)) : redirect_to(category_path(@category))
  end

  def load_parent_category
    @category = Category.find(params[:category_id])
  end
end

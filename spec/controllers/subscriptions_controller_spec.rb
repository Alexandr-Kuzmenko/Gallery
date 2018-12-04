require 'rails_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  RSpec.describe SubscriptionsController, type: :controller do
    include Devise::Test::ControllerHelpers

    let(:user) { FactoryBot.create(:user) }
    let(:category) { FactoryBot.create(:category) }

    def random_subscription_new
      get :new, params: { subscription: {}, category_id: category.id }
    end

    describe '#new' do
      it 'redirect after create' do
        sign_in user
        random_subscription_new
        fresh_subs = Subscription.last
        expect(response).to redirect_to(category_path(fresh_subs.category))
      end

      it 'db records increase after like' do
        sign_in user
        count = Subscription.count
        random_subscription_new
        expect(count + 1 == Subscription.count).to be_truthy
      end

      it 'db records decrease after dislike' do
        sign_in user
        count = Subscription.count
        random_subscription_new # get subs
        random_subscription_new # discard subs
        expect(count == Subscription.count).to be_truthy
      end
    end
  end
end

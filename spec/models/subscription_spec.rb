require 'rails_helper'

RSpec.describe Subscription, type: :model do
  before(:all) do
    @subscription = FactoryBot.create(:subscription)
  end

  it 'attributes valid?' do
    expect(@subscription).to be_valid
  end

  it 'user must present' do
    subscription = build(:subscription, user: nil)
    expect(subscription).to_not be_valid
  end

  it 'category must present' do
    subscription = build(:subscription, category: nil)
    expect(subscription).to_not be_valid
  end

  it 'bonds category-user unique?' do
    subscription = build(:subscription, user: @subscription.user, category: @subscription.category)
    expect(subscription).to_not be_valid
  end
end

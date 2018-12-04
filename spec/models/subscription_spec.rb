require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:subscription) { FactoryBot.create(:subscription) }

  it 'attributes valid?' do
    expect(subscription).to be_valid
  end

  it 'user must present' do
    next_subs = build(:subscription, user: nil)
    expect(next_subs).to_not be_valid
  end

  it 'category must present' do
    next_subs = build(:subscription, category: nil)
    expect(next_subs).to_not be_valid
  end

  it 'bonds category-user unique?' do
    next_subs = build(:subscription, user: subscription.user, category: subscription.category)
    expect(next_subs).to_not be_valid
  end
end

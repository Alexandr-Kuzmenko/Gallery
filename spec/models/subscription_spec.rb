require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:subscription) { FactoryBot.create(:subscription) }

  describe 'associations' do
    it 'association - category' do
      expect(subscription).to respond_to :category
    end

    it 'association type - category' do
      expect(Subscription.reflect_on_association(:category).macro).to eq :belongs_to
    end

    it 'association - user' do
      expect(subscription).to respond_to :user
    end

    it 'association type - user' do
      expect(Subscription.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'user presence' do
      expect(build(:subscription, user: nil)).to_not be_valid
    end

    it 'category presence' do
      expect(build(:subscription, category: nil)).to_not be_valid
    end

    it 'user-category bond uniqueness' do
      expect(build(:subscription, user: subscription.user, category: subscription.category)).to_not be_valid
    end
  end
end

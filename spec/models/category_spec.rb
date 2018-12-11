require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryBot.create(:category) }
  let(:category_wallpapers) { 6.times { FactoryBot.create(:wallpaper, category: category) } }
  let(:category_subscriptions) { 4.times { FactoryBot.create(:subscription, category: category) } }

  describe 'associations' do
    it 'association - categorized' do
      expect(category).to respond_to :categorized
    end

    it 'association type - categorized' do
      expect(Category.reflect_on_association(:categorized).macro).to eq :belongs_to
    end

    it 'association - wallpapers' do
      expect(category).to respond_to :wallpapers
    end

    it 'association type - wallpapers' do
      expect(Category.reflect_on_association(:wallpapers).macro).to eq :has_many
    end

    it 'association - subscriptions' do
      expect(category).to respond_to :subscriptions
    end

    it 'association type - subscriptions' do
      expect(Category.reflect_on_association(:subscriptions).macro).to eq :has_many
    end

    it 'association - users' do
      expect(category).to respond_to :users
    end

    it 'association type - users' do
      expect(Category.reflect_on_association(:users).macro).to eq :has_many
    end
  end

  describe 'dependent destroy' do
    it 'successful wallpapers destroy' do
      category_wallpapers
      cat_wallpaper = Wallpaper.last
      Category.find(cat_wallpaper.category_id).destroy
      expect(Wallpaper.all.include?(cat_wallpaper)).to be_falsey
    end

    it 'successful subscriptions destroy' do
      category_subscriptions
      cat_sub = Subscription.last
      Category.find(cat_sub.category_id).destroy
      expect(Subscription.all.include?(cat_sub)).to be_falsey
    end
  end

  describe 'validations' do
    it 'name presence' do
      expect(build(:category, name: nil)).to_not be_valid
    end

    it 'name uniqueness' do
      expect(build(:category, name: category.name)).to_not be_valid
    end

    it 'creator presence' do
      expect(build(:category, categorized: nil)).to_not be_valid
    end
  end
end

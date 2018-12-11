require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { FactoryBot.create(:like) }

  describe 'associations' do
    it 'association - wallpaper' do
      expect(like).to respond_to :wallpaper
    end

    it 'association type - wallpaper' do
      expect(Like.reflect_on_association(:wallpaper).macro).to eq :belongs_to
    end

    it 'association - user' do
      expect(like).to respond_to :user
    end

    it 'association type - user' do
      expect(Like.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'user presence' do
      expect(build(:like, user: nil)).to_not be_valid
    end

    it 'wallpaper presence' do
      expect(build(:like, wallpaper: nil)).to_not be_valid
    end

    it 'user-wallpaper bond uniqueness' do
      expect(build(:like, user: like.user, wallpaper: like.wallpaper)).to_not be_valid
    end
  end
end

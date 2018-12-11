require 'rails_helper'

RSpec.describe Wallpaper, type: :model do
  let(:wallpaper) { FactoryBot.create(:wallpaper) }
  let(:wallpaper_likes) { 5.times { FactoryBot.create(:like, wallpaper: wallpaper) } }
  let(:wallpaper_comments) { 5.times { FactoryBot.create(:comment, wallpaper: wallpaper) } }

  describe 'associations' do
    it 'association - category' do
      expect(wallpaper).to respond_to :category
    end

    it 'association type - category' do
      expect(Wallpaper.reflect_on_association(:category).macro).to eq :belongs_to
    end

    it 'association - comments' do
      expect(wallpaper).to respond_to :comments
    end

    it 'association type - comments' do
      expect(Wallpaper.reflect_on_association(:comments).macro).to eq :has_many
    end

    it 'association - likes' do
      expect(wallpaper).to respond_to :likes
    end

    it 'association type - likes' do
      expect(Wallpaper.reflect_on_association(:likes).macro).to eq :has_many
    end

    it 'has image' do
      expect(wallpaper).to respond_to :image
    end
  end

  describe 'dependent destroy' do
    it 'successful comments destroy' do
      wallpaper_comments
      wp_comment = Comment.last
      Wallpaper.find(wp_comment.wallpaper_id).destroy
      expect(Comment.all.include?(wp_comment)).to be_falsey
    end

    it 'successful likes destroy' do
      wallpaper_likes
      wp_like = Like.last
      Wallpaper.find(wp_like.wallpaper_id).destroy
      expect(Like.all.include?(wp_like)).to be_falsey
    end
  end

  describe 'validations' do
    it 'title presence' do
      expect(build(:wallpaper, title: nil)).to_not be_valid
    end

    it 'image presence' do
      expect(build(:wallpaper, image: nil)).to_not be_valid
    end

    it 'category_id presence' do
      expect(build(:wallpaper, category_id: nil)).to_not be_valid
    end
  end
end
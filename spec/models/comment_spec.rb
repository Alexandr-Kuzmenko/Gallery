require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.create(:comment) }

  describe 'associations' do
    it 'association - commentable' do
      expect(comment).to respond_to :commentable
    end

    it 'association type - commentable' do
      expect(Comment.reflect_on_association(:commentable).macro).to eq :belongs_to
    end

    it 'association - wallpaper' do
      expect(comment).to respond_to :wallpaper
    end

    it 'association type - wallpapers' do
      expect(Comment.reflect_on_association(:wallpaper).macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'commentable presence' do
      expect(build(:comment, commentable: nil)).to_not be_valid
    end

    it 'text presence' do
      expect(build(:comment, text: nil)).to_not be_valid
    end

    it 'parent wallpaper presence' do
      expect(build(:comment, wallpaper_id: nil)).to_not be_valid
    end

    it 'invalid text length over 1000 symbols' do
      str = ['a'..'z'].map(&:to_a).flatten
      text = ''
      126.times { text << (0..6).map { str[rand(str.length)] }.join + ' ' }
      expect(build(:comment, text: text)).to_not be_valid
    end

    it 'valid text length up to 1000 symbols' do
      str = ['a'..'z'].map(&:to_a).flatten
      text = ''
      125.times { text << (0..6).map { str[rand(str.length)] }.join + ' ' }
      expect(build(:comment, text: text)).to be_valid
    end
  end
end

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.create(:comment) }

  it 'attributes valid?' do
    expect(comment).to be_valid
  end

  it 'text must present' do
    next_comment = build(:comment, text: nil)
    expect(next_comment).to_not be_valid
  end

  it 'source wallpaper must present' do
    next_comment = build(:comment, wallpaper_id: nil)
    expect(next_comment).to_not be_valid
  end

  it 'invalid text over 1000 symbols' do
    str = ['a'..'z'].map(&:to_a).flatten
    text = ''
    126.times { text << (0..6).map { str[rand(str.length)] }.join + ' ' }
    next_comment = build(:comment, text: text)
    expect(next_comment).to_not be_valid
  end

  it 'valid text up to 1000 symbols' do
    str = ['a'..'z'].map(&:to_a).flatten
    text = ''
    125.times { text << (0..6).map { str[rand(str.length)] }.join + ' ' }
    next_comment = build(:comment, text: text)
    expect(next_comment).to be_valid
  end

  it 'Invalid unauthorized creation' do
    next_comment = build(:comment, commentable_type: nil, commentable_id: nil)
    expect(next_comment).to_not be_valid
  end
end

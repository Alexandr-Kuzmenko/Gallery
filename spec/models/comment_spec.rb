require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:all) do
    @comment = FactoryBot.create(:comment)
  end

  it 'attributes valid?' do
    expect(@comment).to be_valid
  end

  it 'text must present' do
    comment = build(:comment, text: nil)
    expect(comment).to_not be_valid
  end

  it 'invalid text over 1000 symbols' do
    str = ['a'..'z'].map(&:to_a).flatten
    text = ""
    126.times { text << (0..6).map { str[rand(str.length)] }.join + " " }
    comment = build(:comment, text: text)
    expect(comment).to_not be_valid
  end

  it 'valid text up to 1000 symbols' do
    str = ['a'..'z'].map(&:to_a).flatten
    text = ""
    125.times { text << (0..6).map { str[rand(str.length)] }.join + " " }
    comment = build(:comment, text: text)
    expect(comment).to be_valid
  end

  it 'Invalid unauthorized creation' do
    comment = build(:comment, commentable_type: nil, commentable_id: nil)
    expect(comment).to_not be_valid
  end
end

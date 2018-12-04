require 'rails_helper'

RSpec.describe Wallpaper, type: :model do
  let(:wallpaper) { FactoryBot.create(:wallpaper) }

  it 'attributes valid?' do
    expect(wallpaper).to be_valid
  end

  it 'title must present' do
    wp = build(:wallpaper, title: nil)
    expect(wp).to_not be_valid
  end

  it 'image must present' do
    wp = build(:wallpaper, image: nil)
    expect(wp).to_not be_valid
  end

  it 'category_id must present' do
    wp = build(:wallpaper, category_id: nil)
    expect(wp).to_not be_valid
  end
end

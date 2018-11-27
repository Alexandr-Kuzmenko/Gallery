require 'rails_helper'

RSpec.describe Wallpaper, type: :model do
  before(:all) do
    @wallpaper = FactoryBot.create(:wallpaper)
  end

  it 'attributes valid?' do
    expect(@wallpaper).to be_valid
  end

  it 'title must present' do
    wp = build(:wallpaper, title: nil)
    expect(wp).to_not be_valid
  end
end

require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:all) do
    @like = FactoryBot.create(:like)
  end

  it 'attributes valid?' do
    expect(@like).to be_valid
  end

  it 'user must present' do
    like = build(:like, user: nil)
    expect(like).to_not be_valid
  end

  it 'wallpaper must present' do
    like = build(:like, wallpaper: nil)
    expect(like).to_not be_valid
  end

  it 'bonds user-wallpaper unique?' do
    like = build(:like, user: @like.user, wallpaper: @like.wallpaper)
    expect(like).to_not be_valid
  end
end

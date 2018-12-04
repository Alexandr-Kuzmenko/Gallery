require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { FactoryBot.create(:like) }

  it 'attributes valid?' do
    expect(like).to be_valid
  end

  it 'user must present' do
    next_like = build(:like, user: nil)
    expect(next_like).to_not be_valid
  end

  it 'wallpaper must present' do
    next_like = build(:like, wallpaper: nil)
    expect(next_like).to_not be_valid
  end

  it 'bonds user-wallpaper unique?' do
    next_like = build(:like, user: like.user, wallpaper: like.wallpaper)
    expect(next_like).to_not be_valid
  end
end

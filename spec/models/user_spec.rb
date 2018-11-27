require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = FactoryBot.create(:user)
  end

  it 'attributes valid?' do
    expect(@user).to be_valid
  end

  it 'email must present' do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it 'email unique?' do
    user = build(:user, email: @user.email)
    expect(user).to_not be_valid
  end

  # it 'nickname unique?' do
  #   user = build(:user, nickname: @user.nickname)
  #   expect(user).to_not be_valid
  # end

  it 'blank password invalid on create' do
    user = build(:user, password: nil)
    expect(user).to_not be_valid
  end

  it '<6 symb password invalid on create' do
    str = [('a'..'z'), ('A'..'Z'), 0..9].map(&:to_a).flatten
    string = (0...5).map { str[rand(str.length)] }.join
    user = build(:user, password: string)
    expect(user).to_not be_valid
  end

  it '>=6 symb password valid on create' do
    str = [('a'..'z'), ('A'..'Z'), 0..9].map(&:to_a).flatten
    string = (0...6).map { str[rand(str.length)] }.join
    user = build(:user, password: string)
    expect(user).to be_valid
  end
end
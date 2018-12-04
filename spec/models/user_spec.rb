require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'attributes valid?' do
    expect(user).to be_valid
  end

  it 'email must present' do
    next_user = build(:user, email: nil)
    expect(next_user).to_not be_valid
  end

  it 'email unique?' do
    next_user = build(:user, email: user.email)
    expect(next_user).to_not be_valid
  end

  # it 'nickname unique?' do
  #   user = build(:user, nickname: @user.nickname)
  #   expect(user).to_not be_valid
  # end

  it 'blank password invalid on create' do
    next_user = build(:user, password: nil)
    expect(next_user).to_not be_valid
  end

  it '<6 symb password invalid on create' do
    str = [('a'..'z'), ('A'..'Z'), 0..9].map(&:to_a).flatten
    string = (0...5).map { str[rand(str.length)] }.join
    next_user = build(:user, password: string)
    expect(next_user).to_not be_valid
  end

  it '>=6 symb password valid on create' do
    str = [('a'..'z'), ('A'..'Z'), 0..9].map(&:to_a).flatten
    string = (0...6).map { str[rand(str.length)] }.join
    next_user = build(:user, password: string)
    expect(next_user).to be_valid
  end
end
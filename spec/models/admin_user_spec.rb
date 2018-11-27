require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  before(:all) do
    @admin = FactoryBot.create(:admin_user)
  end

  it 'attributes valid?' do
    expect(@admin).to be_valid
  end

  it 'email must present' do
    admin = build(:admin_user, email: nil)
    expect(admin).to_not be_valid
  end

  it 'email unique?' do
    admin = build(:admin_user, email: @admin.email)
    expect(admin).to_not be_valid
  end

  it 'nickname unique?' do
    admin = build(:admin_user, nickname: @admin.nickname)
    expect(admin).to_not be_valid
  end

  it 'blank password invalid' do
    admin = build(:admin_user, password: nil)
    expect(admin).to_not be_valid
  end

  it '<6 symb password invalid' do
    str = [('a'..'z'), ('A'..'Z'), 0..9].map(&:to_a).flatten
    string = (0...5).map { str[rand(str.length)] }.join
    admin = build(:admin_user, password: string)
    expect(admin).to_not be_valid
  end

  it '>=6 symb password valid' do
    str = [('a'..'z'), ('A'..'Z'), 0..9].map(&:to_a).flatten
    string = (0...6).map { str[rand(str.length)] }.join
    admin = build(:admin_user, password: string)
    expect(admin).to be_valid
  end
end
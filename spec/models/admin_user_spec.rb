require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  let(:admin) { FactoryBot.create(:admin_user) }

  it 'attributes valid?' do
    expect(admin).to be_valid
  end

  it 'email must present' do
    next_admin = build(:admin_user, email: nil)
    expect(next_admin).to_not be_valid
  end

  it 'email unique?' do
    next_admin = build(:admin_user, email: admin.email)
    expect(next_admin).to_not be_valid
  end

  it 'nickname unique?' do
    next_admin = build(:admin_user, nickname: admin.nickname)
    expect(next_admin).to_not be_valid
  end

  it 'blank password invalid' do
    next_admin = build(:admin_user, password: nil)
    expect(next_admin).to_not be_valid
  end

  it '<6 symb password invalid' do
    str = [('a'..'z'), ('A'..'Z'), 0..9].map(&:to_a).flatten
    string = (0...5).map { str[rand(str.length)] }.join
    next_admin = build(:admin_user, password: string)
    expect(next_admin).to_not be_valid
  end

  it '>=6 symb password valid' do
    str = [('a'..'z'), ('A'..'Z'), 0..9].map(&:to_a).flatten
    string = (0...6).map { str[rand(str.length)] }.join
    next_admin = build(:admin_user, password: string)
    expect(next_admin).to be_valid
  end
end
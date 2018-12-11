require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  before(:all) do
    # @admin = FactoryBot.create(:admin_user)
    # @user = FactoryBot.create(:user)
    # 3.times { FactoryBot.create(:category) }
    # @category = Category.last
    # 2.times { FactoryBot.create(:wallpaper) }
    # FactoryBot.create(:like)
    # FactoryBot.create(:subscription)
    # FactoryBot.create(:activity)
  end

  # describe 'name' do
  #   it 'Random admin_user creating' do
  #     # @user = FactoryBot.create(admin_user)
  #     # @name = Faker::Name.name
  #     # puts "current users email is: #{@user.email}, password: #{@user.encrypted_password}, nickname: #{@user.nickname}"
  #     # expect(@user.email).not_to be_nil
  #     # expect(@category.name).not_to be_nil
  #   end
  # end

  # describe "check fields" do
  #   it { expect(@user).to respond_to(:email) }
  #   it { expect(@user).to respond_to(:description) }
  #   it { expect(@user).to respond_to(:pictures) }
  #   it { expect(@user).to respond_to(:user_categories) }
  #   it { expect(@user).to respond_to(:users) }
  # end

  # describe "GET #index" do
  #   it "returns http success" do
  #     get :index
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "get first user" do
  #   it "returns first user" do
  #     user = User.first
  #     expect(user).to be nil
  #   end
  # end

  # describe "User"
  #   describe ".top" do
  #     before { FactoryGirl.create_list(:user, 3) }
  #     it { User.top(2).should have(2).item }
  #   end
  # end

  # describe 'some user' do
  #   it 'may be created' do
  #     @user = FactoryBot.create(:user)
  #     pust
  #     expect(@user.email).to be != nil
  #   end
  # end
end
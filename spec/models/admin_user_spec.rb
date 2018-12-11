require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  let(:admin) { FactoryBot.create(:admin_user) }
  let(:admin_comments) { 3.times { FactoryBot.create(:comment, commentable: admin) } }

  describe 'associations' do
    it 'association - categories' do
      expect(admin).to respond_to :categories
    end

    it 'association type - categories' do
      expect(AdminUser.reflect_on_association(:categories).macro).to eq :has_many
    end

    it 'association - comments' do
      expect(admin).to respond_to :comments
    end

    it 'association type - comments' do
      expect(AdminUser.reflect_on_association(:comments).macro).to eq :has_many
    end

    it 'has avatar' do
      expect(admin).to respond_to :avatar
    end
  end

  describe 'dependent destroy' do
    it 'successful comments destroy' do
      admin_comments
      comment_last = Comment.last
      AdminUser.find(comment_last.commentable_id).destroy
      expect(Comment.all.include?(comment_last)).to be_falsey
    end
  end

  describe 'validations' do
    it 'email presence' do
      expect(build(:admin_user, email: nil)).to_not be_valid
    end

    it 'email uniqueness' do
      expect(build(:admin_user, email: admin.email)).to_not be_valid
    end

    it 'nickname uniqueness' do
      expect(build(:admin_user, nickname: admin.nickname)).to_not be_valid
    end

    it 'invalid password length (not within [6..20])' do
      expect(build(:admin_user, password: '12345')).to_not be_valid
      expect(build(:admin_user, password: '123456789012345678901')).to_not be_valid
      expect(build(:admin_user, password: nil)).to_not be_valid
    end

    it 'valid password length (within [6..20])' do
      expect(build(:admin_user, password: '123456')).to be_valid
      expect(build(:admin_user, password: '123456assghr9254yuy3')).to be_valid
    end
  end

  describe 'methods' do
    it '#password_required? option 1' do
      expect(AdminUser.new.password_required?).to eq false
    end

    it '#password_required? option 2' do
      expect(admin.password_required?).to eq true
    end
  end
end

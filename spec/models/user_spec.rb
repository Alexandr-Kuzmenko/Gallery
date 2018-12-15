require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:user_likes) { 5.times { FactoryBot.create(:like, user: user) } }
  let(:user_comments) { 5.times { FactoryBot.create(:comment, commentable: user) } }
  let(:user_subscriptions) { 5.times { FactoryBot.create(:subscription, user: user) } }

  describe 'associations' do
    it 'association - categories' do
      expect(user).to respond_to :categories
    end

    it 'association type - categories' do
      expect(User.reflect_on_association(:categories).macro).to eq :has_many
    end

    it 'association - subscriptions' do
      expect(user).to respond_to :subscriptions
    end

    it 'association type - subscriptions' do
      expect(User.reflect_on_association(:subscriptions).macro).to eq :has_many
    end

    it 'association - follows' do
      expect(user).to respond_to :follows
    end

    it 'association type - follows' do
      expect(User.reflect_on_association(:follows).macro).to eq :has_many
    end

    it 'association - comments' do
      expect(user).to respond_to :comments
    end

    it 'association type - comments' do
      expect(User.reflect_on_association(:comments).macro).to eq :has_many
    end

    it 'association - likes' do
      expect(user).to respond_to :likes
    end

    it 'association type - likes' do
      expect(User.reflect_on_association(:likes).macro).to eq :has_many
    end

    it 'association - activities' do
      expect(user).to respond_to :activities
    end

    it 'association type - activities' do
      expect(User.reflect_on_association(:activities).macro).to eq :has_many
    end

    it 'has avatar' do
      expect(user).to respond_to :avatar
    end
  end

  describe 'dependent destroy' do
    it 'successful comments destroy' do
      user_comments
      expect(Comment.last.commentable_type).to eq 'User'
      comment_last = Comment.last
      User.find(comment_last.commentable_id).destroy
      expect(Comment.all.include?(comment_last)).to be_falsey
    end

    it 'successful subscriptions destroy' do
      user_subscriptions
      sub_last = Subscription.last
      User.find(sub_last.user_id).destroy
      expect(Subscription.all.include?(sub_last)).to be_falsey
    end

    it 'successful likes destroy' do
      user_likes
      like_last = Like.last
      User.find(like_last.user_id).destroy
      expect(Like.all.include?(like_last)).to be_falsey
    end
  end

  describe 'validations' do
    it 'email presence' do
      expect(build(:user, email: nil)).to_not be_valid
    end

    it 'email uniqueness' do
      expect(build(:user, email: user.email)).to_not be_valid
    end

    it 'invalid password length (not within [6..20])' do
      expect(build(:user, password: '12345')).to_not be_valid
      expect(build(:user, password: '123456789012345678901')).to_not be_valid
      expect(build(:user, password: nil)).to_not be_valid
    end

    it 'valid password length (within [6..20])' do
      expect(build(:user, password: '123336')).to be_valid
      expect(build(:user, password: '12asghjklhr9254yuy3')).to be_valid
    end

    it 'invalid nickname length (not within [6..20])' do
      expect(build(:user, nickname: 'qwerty_qwerty_qwerty1')).to_not be_valid
    end

    it 'valid nickname length (within [6..20])' do
      expect(build(:user, nickname: 'qop')).to be_valid
      expect(build(:user, nickname: 'qwerty_qwerty_qwerty')).to be_valid
    end
  end

  describe 'methods' do
    it '#from_omniauth' do
      auth_hash = OmniAuth::AuthHash.new(provider: 'google', uid: 12345678, info: {
                                               email: 'some_email@example.com' })
      omni_user = User.from_omniauth(auth_hash)
      expect([omni_user]).to eq User.where(provider: 'google', uid: 12345678, email: 'some_email@example.com')
    end
    # it '#new_with_session' do
    #   inner omniauth mdethod
    # end
  end
end

require 'rails_helper'

class LikesControllerTest < ActionController::TestCase
  RSpec.describe LikesController, type: :controller do
    include Devise::Test::ControllerHelpers

    let(:user) { FactoryBot.create(:user) }
    let(:wallpaper) { FactoryBot.create(:wallpaper) }
    # let(:wallpapers_list) { FactoryBot.create_list(:comment, 10) }
    # let(:users_list) {FactoryBot.create_list(:user, 10)}

    def random_like_new
      get :new, params: { like: {}, wallpaper_id: wallpaper.id }
    end

    describe '#new' do
      it 'redirect after create' do
        sign_in user
        random_like_new
        fresh_like = Like.last
        expect(response).to redirect_to(wallpaper_path(fresh_like.wallpaper))
      end

      it 'db records increase after like' do
        sign_in user
        counter = Like.count
        random_like_new
        expect(counter + 1 == Like.count).to be_truthy
      end

      it 'likes counter increases after create' do
        sign_in user
        counter = wallpaper.likes_count
        random_like_new
        wallpaper.reload
        expect(counter + 1 == wallpaper.likes_count).to be_truthy
      end

      it 'db records decrease after dislike' do
        sign_in user
        random_like_new # like
        count = Like.count
        random_like_new # nail like
        expect(count - 1 == Like.count).to be_truthy
      end

      it 'likes counter decreases if delete' do
        sign_in user
        random_like_new # like
        counter = Wallpaper.last.likes_count
        random_like_new # nail like
        # expect(counter - 1 == wallpaper.likes_count).to be_truthy
        expect(counter - 1 == Wallpaper.last.likes_count).to be_truthy
      end
    end
  end
end

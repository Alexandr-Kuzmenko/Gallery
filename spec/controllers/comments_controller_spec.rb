require 'rails_helper'

class CommentsControllerTest < ActionController::TestCase
  RSpec.describe CommentsController, type: :controller do
    include Devise::Test::ControllerHelpers

    let(:admin) { FactoryBot.create(:admin_user) }
    let(:user) { FactoryBot.create(:user) }
    let(:wallpaper) { FactoryBot.create(:wallpaper) }
    # let(:comment) { FactoryBot.create(:comment) }
    # let(:comment_list) { FactoryBot.create_list(:comment, 10) }

    def random_comment_create
      post :create, params: { comment: { text: Faker::Games::WorldOfWarcraft.quote }, wallpaper_id: wallpaper.id }
    end

    # describe 'before methods' do
    #   it 'proper wallpaper parent preload' do
    #     sign_in user
    #     random_comment_create
    #     puts("total wallpapers: #{Wallpaper.count}, first wp id: #{Wallpaper.first.id}")
    #     puts("total comments: #{Comment.count}, first comment wp_id: #{Comment.first.wallpaper_id}")
    #   end
    # end

    # describe '#index' do
    # end

    # describe '#show' do
    # end

    describe '#new' do
      it 'when logged out' do
        get :new, params: { locale: :en }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'when logged out code 302' do
        get :new, params: { locale: :en }
        expect(response).to have_http_status(302)
      end
    end

    describe '#create' do
      it 'redirect after create' do
        sign_in user
        random_comment_create
        fresh_comment = Comment.last
        expect(response).to redirect_to(wallpaper_path(fresh_comment.wallpaper))
      end

      it 'creating priority to admin' do
        sign_in admin
        sign_in user
        random_comment_create
        expect(Comment.last.commentable_type).to eq('AdminUser')
      end

      it 'when logged out' do
        random_comment_create
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'db records increase after create' do
        sign_in user
        count = Comment.count
        random_comment_create
        expect(count + 1 == Comment.count).to be_truthy
      end
    end
  end
end

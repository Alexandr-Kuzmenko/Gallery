require 'rails_helper'

class WallpapersControllerTest < ActionController::TestCase
  RSpec.describe WallpapersController, type: :controller do
    include Devise::Test::ControllerHelpers
    before(:all) do
      @admin = FactoryBot.create(:admin_user)
      @user = FactoryBot.create(:user)
      @category = FactoryBot.create(:category)
      @wallpaper = FactoryBot.create(:wallpaper)
    end

    def random_wp_create
      img_link = Faker::Internet.url('gandex.ru', '/upl/oboi/gandex.ru-19837_cad81a31a64ce92ac3a1ac69f30fb7ac.jpg')
      post :create, params: { wallpaper: { title: Faker::Book.unique.title, category_id: @category.id,
                                           remote_image_url: img_link } }
    end

    describe '#index' do
      it 'index status 200' do
        get 'index'
        expect(response.status).to eq(200)
      end

      it 'index http success' do
        get 'index', params: { locale: :ru }
        expect(response).to have_http_status(:success)
      end

      it 'render template - index' do
        get :index
        expect(response).to render_template :index
      end

      it 'equal to object if object only one' do
        get :index
        expect(assigns(:wallpapers)).to eq([@wallpaper])
      end
    end

    describe '#show' do
      it 'render template - show' do
        get :show, params: { id: @wallpaper.id }
        expect(response).to render_template :show
      end

      it 'show http success' do
        get :show, params: { id: @wallpaper.id }
        expect(response).to have_http_status(:success)
      end

      it 'wrong locale failure' do
        expect { get :show, params: { id: @wallpaper.id, locale: :fr } }.to raise_error
      end

      it 'no object id failure' do
        expect { get :show, params: { locale: :en } }.to raise_error
      end
    end

    describe '#new' do
      it 'authentication required' do
        get :new, params: { locale: :en }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'render template - new' do
        sign_in @user
        get :new
        expect(response).to render_template :new
      end

      it 'new http success' do
        sign_in @user
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe '#edit' do
      it 'authentication required' do
        get :edit, params: { locale: :en, id: @wallpaper.id }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'no object id failure' do
        sign_in @user
        expect { get :edit, params: { locale: :en } }.to raise_error
      end

      it 'render template - edit' do
        sign_in @user
        get :edit, params: { id: @wallpaper.id }
        expect(response).to render_template :edit
      end

      it 'edit http success' do
        sign_in @user
        get :edit, params: { id: @wallpaper.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe '#create' do
      it 'authentication required' do
        random_wp_create
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'user redirect after create' do
        sign_in @user
        random_wp_create
        expect(response).to redirect_to(wallpapers_path)
      end

      it 'admin redirect after create' do
        sign_in @admin
        random_wp_create
        expect(response).to redirect_to(admin_wallpapers_path)
      end

      it 'db records increase after create' do
        sign_in @user
        count = Wallpaper.count
        random_wp_create
        expect(count + 1 == Wallpaper.count).to be_truthy
      end

      it 'none category create unavailable' do
        sign_in @user
        count = Wallpaper.count
        img_link = Faker::Internet.url('gandex.ru', '/upl/oboi/gandex.ru-19837_cad81a31a64ce92ac3a1ac69f30fb7ac.jpg')
        post :create, params: { wallpaper: { title: Faker::Book.unique.title, remote_image_url: img_link } }
        expect(count == Wallpaper.count).to be_truthy
      end
    end

    describe '#update' do
      it 'authentication required' do
        patch :update, params: { id: @wallpaper.id }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'redirect after update' do
        sign_in @user
        @wp = FactoryBot.create(:wallpaper)
        patch :update, params: { wallpaper: { title: Faker::Book.unique.title }, id: @wp.id }
        expect(response).to redirect_to(wallpapers_path)
      end

      it 'db record changed after update' do
        sign_in @user
        @wp = FactoryBot.create(:wallpaper)
        record = @wp.title
        patch :update, params: { wallpaper: { title: 'title_has_changed'}, id: @wp.id }
        expect(Wallpaper.find_by_title(record)).to be_nil
      end
    end

    describe '#destroy' do
      it 'no object id failure' do
        expect { delete :destroy, params: { locale: :en } }.to raise_error
      end

      it 'authentication required' do
        delete :destroy, params: { id: @wallpaper.id }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'redirect after destroy' do
        sign_in @user
        delete :destroy, params: { id: @wallpaper.id }
        expect(response).to redirect_to(wallpapers_path)
      end
    end
  end
end

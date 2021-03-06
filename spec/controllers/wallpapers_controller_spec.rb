require 'rails_helper'

class WallpapersControllerTest < ActionController::TestCase
  RSpec.describe WallpapersController, type: :controller do
    include Devise::Test::ControllerHelpers

    let(:user) { FactoryBot.create(:user) }
    let(:category) { FactoryBot.create(:category) }
    let(:wallpaper) { FactoryBot.create(:wallpaper) }

    def random_wp_create
      img_link = Faker::Internet.url('gandex.ru', '/upl/oboi/gandex.ru-19837_cad81a31a64ce92ac3a1ac69f30fb7ac.jpg')
      post :create, params: { wallpaper: { title: Faker::Book.unique.title, category_id: category.id,
                                           remote_image_url: img_link } }
    end

    describe '#index' do
      subject { get :index }

      it 'index status 200' do
        expect(subject.status).to eq(200)
      end

      it 'rendered template index' do
        expect(subject).to render_template :index
      end

      it 'equal to object when objects count: 1' do
        subject
        expect(assigns(:wallpapers)).to eq([wallpaper])
      end

      it 'rendered template http success' do
        get 'index', params: { locale: :ru }
        expect(response).to have_http_status(:success)
      end
    end

    describe '#show' do
      subject { get :show, params: { id: wallpaper.id } }

      it 'rendered template show' do
        expect(subject).to render_template :show
      end

      it 'rendered template http success' do
        expect(subject).to have_http_status(:success)
      end

      it 'when wrong locale' do
        expect { get :show, params: { id: wallpaper.id, locale: :fr } }.to raise_error
      end

      it 'when no param :id' do
        expect { get :show, params: { locale: :en } }.to raise_error
      end
    end

    describe '#new' do
      subject do
        sign_in user
        get :new
      end

      it 'rendered template new' do
        expect(subject).to render_template :new
      end

      it 'rendered template http success' do
        expect(subject).to have_http_status(:success)
      end

      it 'when logged out' do
        get :new, params: { locale: :en }
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    describe '#edit' do
      subject do
        sign_in user
        get :edit, params: { id: wallpaper.id }
      end

      it 'rendered template edit' do
        expect(subject).to render_template :edit
      end

      it 'rendered template http success' do
        expect(subject).to have_http_status(:success)
      end

      it 'when logged out' do
        get :edit, params: { locale: :en, id: wallpaper.id }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'when no param :id' do
        sign_in user
        expect { get :edit, params: { locale: :en } }.to raise_error
      end
    end

    describe '#create' do
      let(:admin) { FactoryBot.create(:admin_user) }

      it 'when logged out' do
        random_wp_create
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'user redirect after create' do
        sign_in user
        random_wp_create
        expect(response).to redirect_to(wallpapers_path)
      end

      it 'admin redirect after create' do
        sign_in admin
        random_wp_create
        expect(response).to redirect_to(admin_wallpapers_path)
      end

      it 'db records increase after create' do
        sign_in user
        count = Wallpaper.count
        random_wp_create
        expect(count + 1 == Wallpaper.count).to be_truthy
      end

      it 'unsuccessful creation do not get into db' do
        sign_in user
        count = Wallpaper.count
        img_link = Faker::Internet.url('gandex.ru', '/upl/oboi/gandex.ru-19837_cad81a31a64ce92ac3a1ac69f30fb7ac.jpg')
        post :create, params: { wallpaper: { title: Faker::Book.unique.title, remote_image_url: img_link } }
        expect(count == Wallpaper.count).to be_truthy
      end
    end

    describe '#update' do
      it 'when logged out' do
        patch :update, params: { id: wallpaper.id }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'redirect after update' do
        sign_in user
        patch :update, params: { wallpaper: { title: Faker::Book.unique.title }, id: wallpaper.id }
        expect(response).to redirect_to(wallpapers_path)
      end

      it 'db record have changed' do
        sign_in user
        record = wallpaper.title
        patch :update, params: { wallpaper: { title: 'title_has_changed'}, id: wallpaper.id }
        expect(Wallpaper.find_by_title(record)).to be_nil
      end
    end

    describe '#destroy' do
      it 'when no param :id' do
        expect { delete :destroy, params: { locale: :en } }.to raise_error
      end

      it 'when logged out' do
        delete :destroy, params: { id: wallpaper.id }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'redirect after destroy' do
        sign_in user
        delete :destroy, params: { id: wallpaper.id }
        expect(response).to redirect_to(wallpapers_path)
      end
    end
  end
end

require 'rails_helper'

class UsersControllerTest < ActionController::TestCase
  RSpec.describe UsersController, type: :controller do
    include Devise::Test::ControllerHelpers

    let(:user) { FactoryBot.create(:user) }
    let(:category) { FactoryBot.create(:category) }
    let(:wallpaper) { FactoryBot.create(:wallpaper) }

    describe '#index' do
    #   subject { get :index }
    #
    #   it 'index status 200' do
    #     expect(subject.status).to eq(200)
    #   end
    #
    #   it 'render template - index' do
    #     expect(subject).to render_template :index
    #   end
    #
    #   it 'equal to object if object only one' do
    #     subject
    #     expect(assigns(:wallpapers)).to eq([wallpaper])
    #   end
    #
    #   it 'index http success' do
    #     get 'index', params: { locale: :ru }
    #     expect(response).to have_http_status(:success)
    #   end
    #
    #   subject { get :show, params: { id: wallpaper.id } }
    #
    #   it 'render template - show' do
    #     expect(subject).to render_template :show
    #   end
    #
    #   it 'show http success' do
    #     expect(subject).to have_http_status(:success)
    #   end
    #
    #   it 'wrong locale failure' do
    #     expect { get :show, params: { id: wallpaper.id, locale: :fr } }.to raise_error
    #   end
    #
    #   it 'no object id failure' do
    #     expect { get :show, params: { locale: :en } }.to raise_error
    #   end
    end

    # describe '#edit' do
    #   subject do
    #     sign_in user
    #     get :edit, params: { id: wallpaper.id }
    #   end
    #
    #   it 'render template - edit' do
    #     expect(subject).to render_template :edit
    #   end
    #
    #   it 'edit http success' do
    #     expect(subject).to have_http_status(:success)
    #   end
    #
    #   it 'authentication required' do
    #     get :edit, params: { locale: :en, id: wallpaper.id }
    #     expect(response).to redirect_to('/users/sign_in')
    #   end
    #
    #   it 'no object id failure' do
    #     sign_in user
    #     expect { get :edit, params: { locale: :en } }.to raise_error
    #   end
    # end

    # describe '#update' do
    #   it 'authentication required' do
    #     patch :update, params: { id: wallpaper.id }
    #     expect(response).to redirect_to('/users/sign_in')
    #   end
    #
    #   it 'redirect after update' do
    #     sign_in user
    #     patch :update, params: { wallpaper: { title: Faker::Book.unique.title }, id: wallpaper.id }
    #     expect(response).to redirect_to(wallpapers_path)
    #   end
    #
    #   it 'db record changed after update' do
    #     sign_in user
    #     record = wallpaper.title
    #     patch :update, params: { wallpaper: { title: 'title_has_changed'}, id: wallpaper.id }
    #     expect(Wallpaper.find_by_title(record)).to be_nil
    #   end
    # end




  end
end

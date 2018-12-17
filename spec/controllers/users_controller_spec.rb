require 'rails_helper'

class UsersControllerTest < ActionController::TestCase
  RSpec.describe UsersController, type: :controller do
    include Devise::Test::ControllerHelpers

    let(:user) { FactoryBot.create(:user) }
    let(:category) { FactoryBot.create(:category) }
    let(:wallpaper) { FactoryBot.create(:wallpaper) }

    describe '#index' do
      subject do
        sign_in user
        get :index
      end

      it 'when logged out' do
        get :index
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'index status 200' do
        expect(subject.status).to eq(200)
      end

      it 'rendered template index' do
        expect(subject).to render_template :index
      end

      it 'rendered template http success' do
        expect(subject).to have_http_status(:success)
      end
    end

    describe '#edit' do
      subject do
        sign_in user
        get :edit, params: { id: user.id }
      end

      it 'rendered template edit' do
        expect(subject).to render_template :edit
      end

      it 'rendered template http success' do
        expect(subject).to have_http_status(:success)
      end

      it 'when logged out' do
        get :edit, params: { locale: :en, id: user.id }
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    describe '#update' do
      it 'when logged out' do
        patch :update, params: { id: user.id }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'redirect after update' do
        sign_in user
        patch :update, params: { user: { nickname: 'new nickname' }, id: user.id }
        expect(response).to redirect_to(users_path)
      end

      it 'db record params have changed' do
        sign_in user
        record = user.nickname
        patch :update, params: { user: { nickname: 'new nickname' }, id: user.id }
        expect(User.find_by_nickname(record)).to be_nil
      end
    end

    describe '#destroy' do
      it 'when logged out' do
        delete :destroy, params: { id: user.id }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'redirect after destroy' do
        sign_in user
        delete :destroy, params: { id: user.id }
        expect(response).to redirect_to(root_path)
      end

      it 'db record absent after delete' do
        sign_in user
        id = user.id
        delete :destroy, params: { id: user.id }
        expect(User.find_by_id(id)).to be_nil
      end
    end
  end
end

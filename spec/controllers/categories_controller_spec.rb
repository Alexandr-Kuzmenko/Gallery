require 'rails_helper'

class CategoriesControllerTest < ActionController::TestCase
  RSpec.describe CategoriesController, type: :controller do
    include Devise::Test::ControllerHelpers
    # get :index
    # assert_response :success
    # def setup
    #   @request.env["devise.mapping"] = Devise.mappings[:user]
    #   sign_in FactoryBot.create(:user)
    # end

    let(:category) { FactoryBot.create(:category) }
    let(:user) { FactoryBot.create(:user) }

    def random_cat_create
      post :create, params: { category: { name: Faker::Book.unique.genre } }
    end

    describe '#index' do
      subject { get :index }

      it 'index status 200' do
        expect(subject.status).to eq(200)
      end

      it 'rendered template index' do
        expect(subject).to render_template :index
      end

      it 'rendered template http success' do
        get 'index', params: { locale: :en }
        expect(response).to have_http_status(:success)
      end

      it 'equal to object when objects count: 1' do
        expect(assigns(:categories)).to eq([category])
      end
    end

    describe '#show' do
      subject { get :show, params: { id: category.id } }

      it 'rendered template show' do
        expect(subject).to render_template :show
      end

      it 'rendered template http success' do
        expect(subject).to have_http_status(:success)
      end

      it 'when wrong locale' do
        expect { get :show, params: { id: category.id, locale: :fr } }.to raise_error
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

      it 'when logged out' do
        get :new, params: { locale: :en }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'rendered template new' do
        expect(subject).to render_template :new
      end

      it 'rendered template http success' do
        expect(subject).to have_http_status(:success)
      end
    end

    describe '#edit' do
      subject do
        sign_in user
        get :edit, params: { id: category.id }
      end

      it 'rendered template edit' do
        expect(subject).to render_template :edit
      end

      it 'rendered template http success' do
        expect(subject).to have_http_status(:success)
      end

      it 'when logged out' do
        get :edit, params: { locale: :en, id: category.id }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'when no param :id' do
        sign_in user
        expect { get :edit, params: { locale: :en } }.to raise_error
      end
    end

    describe '#create' do
      let(:admin) { FactoryBot.create(:admin_user) }
      subject do
        sign_in user
        random_cat_create
      end

      it 'redirect after create' do
        expect(subject).to redirect_to(categories_path)
      end

      it 'creating priority to admin' do
        sign_in admin
        subject
        expect(Category.last.categorized_type).to eq('AdminUser')
      end

      it 'when logged out' do
        random_cat_create
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'db records increase after create' do
        sign_in user
        count = Category.count
        random_cat_create
        expect(count + 1 == Category.count).to be_truthy
      end
    end

    describe '#update' do
      it 'when logged out' do
        patch :update, params: { id: category.id }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'redirect after update' do
        sign_in user
        patch :update, params: { category: { name: Faker::Book.unique.genre }, id: category.id }
        expect(response).to redirect_to(categories_path)
      end

      it 'db record params have changed' do
        sign_in user
        record = category.name
        patch :update, params: { category: { name: 'name_has_changed' }, id: category.id }
        expect(Category.find_by_name(record)).to be_nil
      end
    end

    describe '#destroy' do
      it 'when no param :id' do
        expect { delete :destroy, params: { locale: :en } }.to raise_error
      end

      it 'when logged out' do
        delete :destroy, params: { id: category.id }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'redirect after destroy' do
        sign_in user
        delete :destroy, params: { id: category.id }
        expect(response).to redirect_to(categories_path)
      end

      it 'db record absent after delete' do
        sign_in user
        id = category.id
        delete :destroy, params: { id: category.id }
        expect(Category.find_by_id(id)).to be_nil
      end

      it 'preventing deleting trigger' do
        category.update!(locked: true)
        id = category.id
        sign_in user
        delete :destroy, params: { id: id }
        expect(Category.find_by_id(id)).not_to be_nil
      end
    end
  end
end


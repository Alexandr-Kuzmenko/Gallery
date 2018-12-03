require 'rails_helper'

class CategoriesControllerTest < ActionController::TestCase
  RSpec.describe CategoriesController, type: :controller do
    include Devise::Test::ControllerHelpers
    before(:all) do
      @admin = FactoryBot.create(:admin_user)
      @user = FactoryBot.create(:user)
      @category = FactoryBot.create(:category)
      # get :index
      # assert_response :success
    end

    # def setup
    #   @request.env["devise.mapping"] = Devise.mappings[:user]
    #   sign_in FactoryBot.create(:user)
    # end

    def random_cat_create
      post :create, params: { category: { name: Faker::Book.unique.genre } }
    end

    describe '#index' do
      it 'index status 200' do
        get 'index'
        expect(response.status).to eq(200)
      end

      it 'index http success' do
        get 'index', params: { locale: :en }
        expect(response).to have_http_status(:success)
      end

      it 'render template - index' do
        get :index
        expect(response).to render_template :index
      end

      it 'equal to object if object only one' do
        get :index
        expect(assigns(:categories)).to eq([@category])
      end
    end

    describe '#show' do
      it 'render template - show' do
        get :show, params: { id: @category.id }
        expect(response).to render_template :show
      end

      it 'show http success' do
        get :show, params: { id: @category.id }
        expect(response).to have_http_status(:success)
      end

      it 'wrong locale failure' do
        expect { get :show, params: { id: @category.id, locale: :fr } }.to raise_error
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
        get :edit, params: { locale: :en, id: @category.id }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'no object id failure' do
        sign_in @user
        expect { get :edit, params: { locale: :en } }.to raise_error
      end

      it 'render template - edit' do
        sign_in @user
        get :edit, params: { id: @category.id }
        expect(response).to render_template :edit
      end

      it 'edit http success' do
        sign_in @user
        get :edit, params: { id: @category.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe '#create' do
      it 'authentication required' do
        random_cat_create
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'redirect after create' do
        sign_in @user
        random_cat_create
        expect(response).to redirect_to(categories_path)
      end

      it 'db records increase after create' do
        sign_in @user
        count = Category.count
        random_cat_create
        expect(count + 1 == Category.count).to be_truthy
      end

      it 'creating priority to admin' do
        sign_in @admin
        sign_in @user
        random_cat_create
        expect(Category.last.categorized_type).to eq('AdminUser')
      end
    end

    describe '#update' do
      it 'authentication required' do
        patch :update, params: { id: @category.id }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'redirect after update' do
        sign_in @user
        patch :update, params: { category: { name: Faker::Book.unique.genre }, id: @category.id }
        expect(response).to redirect_to(categories_path)
      end

      it 'db record changed after update' do
        sign_in @user
        record = @category.name
        patch :update, params: { category: { name: 'name_has_changed' }, id: @category.id }
        expect(Category.find_by_name(record)).to be_nil
      end
    end

    describe '#destroy' do
      it 'no object id failure' do
        expect { delete :destroy, params: { locale: :en } }.to raise_error
      end

      it 'authentication required' do
        delete :destroy, params: { id: @category.id }
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'redirect after destroy' do
        sign_in @user
        delete :destroy, params: { id: @category.id }
        expect(response).to redirect_to(categories_path)
      end

      it 'db record absent after delete' do
        sign_in @user
        id = @category.id
        delete :destroy, params: { id: @category.id }
        expect(Category.find_by_id(id)).to be_nil
      end

      it 'preventing deleting trigger' do
        Category.last.update!(locked: true)
        id = Category.last.id
        sign_in @user
        delete :destroy, params: { id: Category.last.id }
        expect(Category.find_by_id(id)).not_to be_nil
      end
    end
  end
end


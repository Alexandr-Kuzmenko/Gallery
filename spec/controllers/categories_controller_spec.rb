require 'rails_helper'

class CategoriesControllerTest < ActionController::TestCase
  RSpec.describe CategoriesController, type: :controller do
    include Devise::Test::ControllerHelpers
    before(:all) do
      @admin = FactoryBot.create(:admin_user)
      @user = FactoryBot.create(:user)
      @category = FactoryBot.create(:category)
      # @cat2 = FactoryBot.create(:category)
    end
    #before(:create) do
    #  @cat2 =
    #end

    def setup
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryBot.create(:user)
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

      it 'no id failure' do
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

      it 'no id failure' do
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
      # it 'redirect after create' do
      #
      #   sign_in @user
      #   post :create, { categoty: { name: Faker::Book.unique.genre } }#, categorized_id: @user.id, categorized_type: @user.class }
      #   # expect { }.to redirect_to('/categories')
      # end
    end

    describe '#update' do
      it 'redirect after update' do

      end
    end

    describe '#destroy' do
      it 'redirect after destroy' do

      end
    end
      # expect(subject).to redirect_to :action => :show,
      # :id => assigns(:widget).id
  end
end
#    get :index
#    assert_response :success

require 'rails_helper'

RSpec.describe "categories/index", type: :view do
  include Devise::Test::ControllerHelpers

  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }
  context 'Index rendered with less then per_page categories' do
    #before(:all) do
    #  #get :index
    #  #render
    #
    #end
    #
    #it 'proper page' do
    #  sign_in user
    #  assign(:categories, [
    #    user.categories.create(name: 'alpha'),
    #    user.categories.create(name: 'beta')
    #  ], :locale :en)
    #  # get :index, params:
    #  render
    #  expect(rendered).to match /alpha/
    #  expect(rendered).to match /alpha/
    #end
    #expect(page).to have_content('Email')
    #expect(page).to have_text("Email:")
  end




  # context 'named category rendered' do
  #   before(:all) do
  #     assign(:locale, :ru)
  #     assign(:category, Category.create(name: 'alpha'))
  #     assign(:categories, Category.all)
  #     assign(:id, category.id)
  #   end
  # 
  #   subject do
  #     puts category
  #     render
  #   end
  # 
  #   it 'display show page' do
  #     expect(subject).to match /alpha/
  #   end
  # end

end

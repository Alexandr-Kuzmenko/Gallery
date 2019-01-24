require 'rails_helper'

RSpec.describe 'Categories behavior', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }

  describe 'Visiting root' do
    it 'expect rendered header' do
      root_url.eql?(categories_url) ? visit(root_url) : visit(categories_url)
      expect(page).to have_text('Wallpapers gallery')
    end

    it 'expect no welcome text when unlogined' do
      visit root_url
      expect(page).not_to have_text('Welcome')
    end

    it 'expect login modal window' do
      visit root_url
      expect(page).to have_selector('#sign_in_modal')
    end

    it 'expect localization dropdown menu' do
      visit root_url
      expect(page).to have_selector('#top5categories')
    end

    it 'expect top categories dropdown menu' do
      visit root_url
      expect(page).to have_selector('#localization')
    end

    it 'expect new_category modal window' do
      sign_in user
      visit categories_url
      expect(page).to have_selector('#new_ctg_btn')
    end
  end

  describe 'Visiting categories/show' do
    it 'expect Follow/Unfollow button' do
      sign_in user
      visit category_url(id: category)
      expect(page).to have_selector('#follow')
    end

    it 'expect empty_cat button' do
      sign_in user
      category
      visit categories_url
      expect(page).to have_selector('#empty_ctg_btn')
    end
  end

  describe 'Tests in browser', driver: :selenium_chrome do
    it 'successful category creating' do
      login_as(user)
      visit categories_path
      count = Category.count
      find('#new_ctg_btn').click
      fill_in 'category[name]', with: 'some_new_category'
      find('#modal-save').click
      # expect(page).to have_text("some_new_category") - wrong if page 2...
      expect(Category.count).to be > count
      find_link('Log out').click
    end

    it 'unsuccessful category creating' do
      sign_in user
      visit categories_path
      count = Category.count
      find('#new_ctg_btn').click
      fill_in 'category[name]', with: ''
      find('#modal-save').click
      expect(Category.count).to eq count
    end
  end
end

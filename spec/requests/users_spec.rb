require 'rails_helper'

RSpec.describe 'Users behavior', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'Tests in browser', driver: :selenium_chrome do
    before(:all) do
      User.create(email: '123@example.com', password: 'password')
    end

    it 'successful registration' do
      expect {
      visit root_path
      find('#sign_up').click
      fill_in 'user[email]', with: '234@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      find('[name=commit]').click
      }.to change(User, :count).by(1)
    end

    it 'unsuccessful registration' do
      visit root_path
      find('#sign_up').click
      fill_in 'user[email]', with: '234@example.com'
      fill_in 'user[password]', with: 'password'
      find('[name=commit]').click
      expect(page).to have_text('error')
    end

    it 'successful login' do
      visit root_path
      find_button('#sign_in_modal').click
      fill_in 'user[email]', with: '123@example.com'
      fill_in 'user[password]', with: 'password'
      find('[name=commit]').click
      expect(page).to have_text('Welcome')
    end

    it 'unsuccessful login' do
      visit root_path
      find_button('#sign_in_modal').click
      fill_in 'user[email]', with: '123@example.com'
      fill_in 'user[password]', with: ''
      find('[name=commit]').click
      expect(page).not_to have_text('Welcome')
    end
  end
end

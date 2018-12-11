require 'rails_helper'

RSpec.describe 'Categories behavior', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }

  describe 'categories walking' do
    before(:all) do
      User.create(email: '123@example.com', password: 'password')
    end

    context 'Visiting root' do
      it 'expect rendered header' do
        visit root_url
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
        # find('#top5categories')
        expect(page).to have_selector('#top5categories')
      end

      it 'expect top categories dropdown menu' do
        visit root_url
        expect(page).to have_selector('#localization')
      end
    end

    context 'Visiting categories/index' do
      it 'expect new_category modal window' do
        visit categories_url
        expect(page).to have_selector('#new_ctg_btn')
      end
    end

    context 'Visiting categories/show' do
      it 'expect Follow/Unfollow button' do
        sign_in user
        visit category_url(id: category)
        expect(page).to have_selector('#follow')
      end
    end

    context 'Tests in browser', driver: :selenium_chrome do
      it 'successful login' do
        visit root_path
        find_button('#sign_in_modal').click
        fill_in 'user[email]', with: '123@example.com'
        fill_in 'user[password]', with: 'password'
        find('[name=commit]').click
        expect(page).to have_text('Welcome')
      end

      it 'successful category creating' do
        sign_in user
        visit categories_path
        count = Category.count
        find('#new_ctg_btn').click
        fill_in 'category[name]', with: 'some_new_category'
        find('#modal-save').click
        expect(Category.count).to be > count
        find_link('Log out').click
      end

      it 'unsuccessful login' do
        visit root_path
        find_button('#sign_in_modal').click
        fill_in 'user[email]', with: '123@example.com'
        fill_in 'user[password]', with: ''
        find('[name=commit]').click
        expect(page).not_to have_text('Welcome')
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
end

# it 'check sign_in method' do
#   sign_in user
#   visit root_url
#   expect(page).to have_text('Welcome')
# end



      #expect(response).to have_http_status(:success)

      #puts page.html
      # puts User.first.email
      #page.should have_content("Wallpapers gallery")
      #expect(page).to have_selector('.message', text: 'Welcome')


  # it "should have a name field" do
  #   get :new
  #   response.should have_selector("input[name='user[name]'][type='text']")
  # end
  # describe 'Creating new' do
  #
  #   describe 'success' do
  #     it 'expect new category' do
  #       # lambda do
  #       # puts "user: id - #{user.id}, email - #{user.email}"
  #       # sing_in user
  #       #   visit new_category_path
  #       #   fill_in 'Name', with: 'automated category'
  #       #   click_button 'Save'
  #       #   # expect(response).to have_selector("div.flash.success",
  #       #   #                               :content => "Welcome")
  #       #   expect(response).to render_template('categories/index')
  #       #   #end.should change(User, :count).by(1)
  #       # end
  #       # expect(lambda).to change(Category, :count).by(1)
  #     end
  #   end
  #

  # describe 'Delete just created category' do
  #
  # end



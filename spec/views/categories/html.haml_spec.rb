require 'rails_helper'



RSpec.describe "categories/index", type: :view do
  include Devise::Test::ControllerHelpers

  let(:user) { FactoryBot.create(:user) }

  # context 'Index rendered with less then per_page categories' do
  #
  # end
end

RSpec.describe 'categories/show', type: :view do
  include Devise::Test::ControllerHelpers

  let(:user) { FactoryBot.create(:user) }

  context 'named category rendered' do
    before(:each) do
      assign(:category, user.categories.create(name: 'alpha'))
    end

    subject { render }

    it 'display show page' do
      expect(subject).to match /alpha/
    end
  end
end

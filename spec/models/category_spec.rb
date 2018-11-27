require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:all) do
    @category = FactoryBot.create(:category)
  end

  it 'attributes valid?' do
    expect(@category).to be_valid
  end

  it 'name must present' do
    category = build(:category, name: nil)
    expect(category).to_not be_valid
  end

  it 'name unique?' do
    category = build(:category, name: @category.name)
    expect(category).to_not be_valid
  end

  it 'Invalid unauthorized creation' do
    category = build(:category, categorized_type: nil, categorized_id: nil)
    expect(category).to_not be_valid
  end
end

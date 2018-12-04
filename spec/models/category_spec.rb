require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryBot.create(:category) }

  it 'attributes valid?' do
    expect(category).to be_valid
  end

  it 'name must present' do
    next_category = build(:category, name: nil)
    expect(next_category).to_not be_valid
  end

  it 'name unique?' do
    next_category = build(:category, name: category.name)
    expect(next_category).to_not be_valid
  end

  it 'Invalid unauthorized creation' do
    next_category = build(:category, categorized_type: nil, categorized_id: nil)
    expect(next_category).to_not be_valid
  end
end

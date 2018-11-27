require 'rails_helper'

RSpec.describe Activity, type: :model do
  before(:all) do
    @activity = FactoryBot.create(:activity)
  end

  it 'attributes valid?' do
    expect(@activity).to be_valid
  end

  it 'user must present' do
    activity = build(:activity, user: nil)
    expect(activity).to_not be_valid
  end
end




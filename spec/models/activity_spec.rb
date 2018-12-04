require 'rails_helper'

RSpec.describe Activity, type: :model do
  let(:activity) { FactoryBot.create(:activity) }

  it 'attributes valid?' do
    expect(activity).to be_valid
  end

  it 'user must present' do
    next_activity = build(:activity, user: nil)
    expect(next_activity).to_not be_valid
  end
end




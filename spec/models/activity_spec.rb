require 'rails_helper'

RSpec.describe Activity, type: :model do
  let(:activity) { FactoryBot.create(:activity) }

  describe 'association' do
    it 'association - user' do
      expect(activity).to respond_to :user
    end

    it 'association type - user' do
      expect(Activity.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'user presence' do
      next_activity = build(:activity, user_id: nil)
      expect(next_activity).to_not be_valid
    end

    it 'action presence' do
      next_activity = build(:activity, action_type: nil)
      expect(next_activity).to_not be_valid
    end

    it 'url_page presence' do
      next_activity = build(:activity, url_page: nil)
      expect(next_activity).to_not be_valid
    end
  end
end

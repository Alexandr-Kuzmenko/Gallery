FactoryBot.define do
  factory :activity, class: Activity do
    action_type { ['navigation', 'sign in', 'sign out', 'likes', 'dislikes', 'comments'].sample }
    user
    url_page { Faker::Internet.url }
  end
end

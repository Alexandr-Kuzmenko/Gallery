FactoryBot.define do
  factory :comment, class: Comment do
    text { Faker::Games::WorldOfWarcraft.quote }
    wallpaper
    association :commentable, factory: [:user, :admin_user].sample
  end
end
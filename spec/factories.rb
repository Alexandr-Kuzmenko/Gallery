FactoryBot.define do
  factory :activity, class: Activity do
    action_type { ['navigation', 'sign in', 'sign out', 'likes', 'dislikes', 'comments'].sample }
    user
    url_page { Faker::Internet.url }
  end

  factory :admin_user, class: AdminUser do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(8) }
    # password_confirmation { Faker::Internet.password(8) }
    nickname { Faker::Internet.unique.username(8) }
  end

  factory :category, class: Category do
    name { Faker::Book.unique.genre }
    # locked false
    association :categorized, factory: [:user, :admin_user].sample
  end

  factory :comment, class: Comment do
    text { Faker::Games::WorldOfWarcraft.quote }
    wallpaper
    association :commentable, factory: [:user, :admin_user].sample
  end

  factory :like, class: Like do
    wallpaper
    user
  end

  factory :subscription, class: Subscription do
    user
    category
  end

  factory :user, class: User do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(8) }
    nickname { Faker::Internet.unique.username(8) }
  end

  factory :wallpaper, class: Wallpaper do
    title { Faker::Book.unique.title }
    category
    remote_image_url { Faker::Internet.url('gandex.ru', '/upl/oboi/gandex.ru-19837_cad81a31a64ce92ac3a1ac69f30fb7ac.jpg') }
    # likes_count 0
  end
end

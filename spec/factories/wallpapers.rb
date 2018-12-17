FactoryBot.define do
  factory :wallpaper, class: Wallpaper do
    title { Faker::Book.unique.title }
    category
    remote_image_url { Faker::Internet.url('gandex.ru', '/upl/oboi/gandex.ru-19837_cad81a31a64ce92ac3a1ac69f30fb7ac.jpg') }
    # likes_count 0
  end
end

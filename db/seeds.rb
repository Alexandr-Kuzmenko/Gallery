def random_likes_create
  wp_count = Wallpaper.all.size
  if Wallpaper.first && User.first
    id = User.first.id
    10.times do
      wid = rand(wp_count) + 1
      Like.create!(user_id: id, wallpaper_id: wid) unless Like.find_by wallpaper_id: wid, user_id: id
    end
  end
end

def random_commnets_create
  wp_count = Wallpaper.all.size
  if Wallpaper.first && User.first
    user = User.first
    3.times do
      wid = rand(wp_count) + 1
      user.comments.create!(wallpaper_id: wid, text: 'random comment') unless user.comments.find_by wallpaper_id: wid
    end
  end
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
Rake::Task["autofilling:init_filling"].execute
random_likes_create
random_commnets_create

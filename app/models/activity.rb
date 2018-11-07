class Activity < ApplicationRecord
  #enum action: { sign_in: 1, sign_out: 2, navigation: 3, comment: 4, likes: 5, nail_like: 6 }
  belongs_to :user
end

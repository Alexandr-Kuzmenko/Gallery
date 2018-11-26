# require 'faker'
FactoryBot.define do
  factory :admin_user, class: AdminUser do
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
  #  password_confirmation { Faker::Internet.password(8) }
    nickname { Faker::Internet.username(8) }
  end
  # factory :user, class: User do
  #   email 'some_email_001@example.com'
  #   password 'password'
  #   password_confirmation 'password'
  #   nickname 'spec_user'
  # end
  # factory :category, class: Category do
  #   name 'spec_category'
  #   locked false
  #   association :categorized, factory: [:user, :admin_user]
  # end
end

#  example_below
#  spec/factories/students.rb
#  FactoryGirl.define do
#    factory :student do
#      full_name     { Faker::Name.name }
#      age           { Faker::Number.between(18, 65) }
#      email         { Faker::Internet.email}
#      phone_number  { Faker::PhoneNumber.phone_number }
#      university
#    end
#  end
#  spec/factories/universities.rb
#  FactoryGirl.define do
#    factory :university do
#      name     { Faker::University.name }
#    end
#  end
FactoryBot.define do
  factory :admin_user, class: AdminUser do
    email 'some_admin_email_001@example.com'
    password 'password'
    password_confirmation 'password'
    nickname 'spec_admin'
  end
  factory :user, class: User do
    email 'some_email_001@example.com'
    password 'password'
    password_confirmation 'password'
    nickname 'spec_user'
  end
  factory :category, class: Category do
    name 'spec_category'
    locked false
    association :categorized, factory: [:user, :admin_user]
  end
end
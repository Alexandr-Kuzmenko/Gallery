FactoryBot.define do
  factory :category, class: Category do
    name { Faker::Company.unique.name }
    # locked false
    association :categorized, factory: [:user, :admin_user].sample
  end
end

FactoryBot.define do
  factory :subscription, class: Subscription do
    user
    category
  end
end
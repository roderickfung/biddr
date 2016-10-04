FactoryGirl.define do
  factory :bid do
    price 1.5
    association :user, factory: :user
    association :item, factory: :item
  end
end

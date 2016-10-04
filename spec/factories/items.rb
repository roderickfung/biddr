FactoryGirl.define do
  factory :item do
    name "MyString"
    description "MyText"
    reserve_price 1.5
    end_date "2016-10-03"
    association :user, factory: :user
  end
end

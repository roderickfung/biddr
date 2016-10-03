FactoryGirl.define do
  factory :item do
    name "MyString"
    description "MyText"
    reserve_price 1.5
    ends_on "2016-10-03"
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    name "MyString"
    description "MyText"
    country_id 1
    lat "9.99"
    lng "9.99"
  end
end

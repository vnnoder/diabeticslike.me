# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :experience do
    user_id 1
    quantity_from 1
     ""
    description "MyText"
    location_id 1
    price "9.99"
    duration "9.99"
    cost_includes "MyText"
  end
end

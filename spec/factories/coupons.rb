FactoryBot.define do
  factory :coupon do
    sequence(:name) { |n| "My Coupon #{n}" }
    code { Faker::Commerce.unique.promotion_code(digits: 6) }
    status { %i(active inactive).sample }
    discount_value { rand(1..99) }
    max_use { rand(1..99) }
    due_date { rand(1..30).days.from_now }
  end
end

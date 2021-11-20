FactoryBot.define do
  factory :product do
    code { Faker::Barcode.unique.ean }
    name { Faker::Name.name }
    price { rand(10.0..300.0).round(2) }
  end
end

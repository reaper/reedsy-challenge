FactoryBot.define do
  factory :product do
    code { Faker::Barcode.unique.ean }
    name { Faker::Name.name }
    price { rand((10 * 10**3)..(300 * 10**3)) }
  end
end

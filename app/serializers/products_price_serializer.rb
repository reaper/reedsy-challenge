class ProductsPriceSerializer < ActiveModel::Serializer
  attributes :codes_with_count, :price_cents, :price

  def price
    Money.from_cents(object.price_cents).format
  end
end

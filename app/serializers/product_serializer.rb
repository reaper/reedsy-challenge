class ProductSerializer < ActiveModel::Serializer
  attributes :code, :name, :price

  def price
    object.price.format
  end
end

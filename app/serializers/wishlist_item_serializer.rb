class WishlistItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :product_id, :user_id, :product
end

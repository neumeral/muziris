class ProductStockSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :product_id, :current_stock, :created_at, :updated_at
end

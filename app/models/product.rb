class Product < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_term, against: [:name, :short_description, :description],
                                   associated_against: {
                                     category: [:name]
                                   },
                                   using: {
                                     tsearch: { prefix: true }
                                   }
  validates :name, presence: true
  belongs_to :category
  has_many :product_images, dependent: :destroy
  has_one :product_stock, dependent: :destroy
  after_create :build_product_stock
  accepts_nested_attributes_for :product_images, allow_destroy: true

  def self.generate_csv
    attributes = ['Name', 'Category', 'Short Description', 'Description', 'Price']
    CSV.generate do |csv|
      csv << attributes
    end
  end

  def build_product_stock
    ProductStock.create(product_id: id)
  end

  def self.import(file)
    CSV.foreach(file, headers: true) do |row|
      product = row.to_hash
      category_name = product['category']
      category = Category.find_by(name: category_name)
      category ||= Category.create!(name: category_name)
      category_id = category.id

      product['category_id'] = category_id
      product.delete('category')

      Product.create! product
    end
  end

  def product_image_url
    product_image = if product_images.count.positive?
                      product_images.first.image_url
                    else
                      ActionController::Base.helpers.asset_path('default_product.jpg')
                    end
  end

  def current_stock
    stock = product_stock.current_stock
    if stock.zero?
      'Out of Stock'
    else
      'In Stock'
    end
  end
end

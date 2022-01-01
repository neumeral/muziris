require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:csv_file) { File.new(fixture_path + '/products.csv') }
  let(:product) { create(:product) }

  it 'should have a title' do
    product.name = nil
    expect(product).to_not be_valid
  end

  it 'should belongs to a categry' do
    product = Product.reflect_on_association(:category)
    expect(product.macro).to eq(:belongs_to)
  end

  it 'should has many  product images' do
    product = Product.reflect_on_association(:product_images)
    expect(product.macro).to eq(:has_many)
  end

  it 'should destroy product images on destroying product' do
    product_image_id = product.product_images.create(main: true).id
    product.destroy
    expect { ProductImage.find(product_image_id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'should import csv file and create products' do
    Product.import(csv_file)
    product = Product.find_by(name: 'Fresho Frozen Green Peas, 2 kg Slider Zip Standy Pouch')
    expect(product).not_to be(nil)
  end

  it 'should generate CSV' do
    expect(Product.generate_csv).to include 'Name'
  end

  it 'should create a product stock' do
    expect(product.product_stock.product_id).to eq(product.id)
  end

  it 'should destroy product stock on destroying product' do
    product_stock_id = product.product_stock.id
    product.destroy
    expect { ProductStock.find(product_stock_id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'should return a default product image' do
    expect(product.product_image_url).to include('/assets/')
  end

  it 'should return a product image' do
    uploader = ImageUploader.new(:store)
    file = File.new(fixture_path + '/bio.jpg')
    uploaded_file = uploader.upload(file)
    product.product_images.create! image_data: uploaded_file.to_json
    expect(product.product_image_url).to include('/uploads/store/')
  end

  it 'should return in stock status' do
    product.product_stock.current_stock = 5
    expect(product.current_stock).to eq('In Stock')
  end

  it 'should return out of stock status' do
    expect(product.current_stock).to eq('Out of Stock')
  end
end

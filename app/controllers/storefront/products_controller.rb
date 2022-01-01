module Storefront
  class ProductsController < StorefrontController
    include Pagy::Backend
    before_action :set_product, only: :show

    def index
      @pagy, @products = pagy(Product.order(updated_at: :desc))
    end

    def show
      @category = Category.find(@product.category_id)
      @featured_products = FeaturedProduct.where(listing_type: 'featured')
    end

    def search
      if params[:section][:term].present?
        @value = params[:section][:term]
        @category_id = params[:section][:category_id]
        p @category_id
        if @category_id == '0'
          @pagy, @products = pagy(Product.search_by_term(@value))
          @text = "#{t('messages.flash.products.search_results_for')} #{@value}"
        else
          @pagy, @products = pagy(Product.where(category_id: @category_id).search_by_term(@value))
        end
      else
        @pagy, @products = pagy(Product.all.order(updated_at: :desc))
      end
      if @products.count.zero?
        @text = "#{t('messages.flash.products.no_items_found_for')} #{@value}"
        @products = Product.where(category_id: Category.first.id).order(updated_at: :desc)
      end
      render :index
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end
  end
end

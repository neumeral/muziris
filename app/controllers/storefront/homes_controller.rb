# frozen_string_literal: true

module Storefront
  class HomesController < StorefrontController
    def show
      @featured_products = FeaturedProduct.where(listing_type: 'featured')
      @best_seller_products = FeaturedProduct.where(listing_type: 'top_selling')
    end
  end
end

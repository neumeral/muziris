module Storefront
  class CategoriesController < StorefrontController
    include Pagy::Backend

    before_action :set_category, only: [:show]

    def show
      @pagy, @products = pagy(@category.products)
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end
  end
end

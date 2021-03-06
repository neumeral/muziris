module Api::V1
  class ProductsController < ApiController
    skip_before_action :authenticate_user_with_api_token
    before_action :set_product, only: [:show, :update, :destroy]
    before_action :authorize_product, only: [:update, :destroy]
    before_action :authorize_products, except: [:search, :index, :update, :destroy]

    def index
      products = Product.order(updated_at: :desc)
      render_json(products)
    end

    def create
      product = Product.create!(product_params)
      if product
        render_json(product)
      else
        render_json
      end
    end

    def show
      render json: @product
    end

    def update
      if @product.update(product_params)
        render_json(@product)
      else
        Rails.logger.info(@product.errors.messages.inspect)
        render_json
      end
    end

    def destroy
      product = @product
      if @product.destroy
        render_json(product)
      else
        render_json
      end
    end

    def search
      product = Product.search_by_term(params[:q])
      render_json(product)
    end

    private

    def render_json(products = nil)
      if products
        serializer = ProductSerializer.new(products)
        render json: serializer
      else
        render json: nil
      end
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(
        :name, :description,
        :slug, :price, :short_description,
        :category, :category_id,
        product_images_attributes: %i[image id _destroy]
      )
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def authorize_product
      authorize @product
    end

    def authorize_products
      authorize Product
    end
  end
end

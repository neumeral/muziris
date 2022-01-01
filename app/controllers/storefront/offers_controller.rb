module Storefront
  class OffersController < StorefrontController
    include Pagy::Backend
    before_action :banners, only: :show

    def show
      @pagy, @banner_items = pagy(BannerItem.order(updated_at: :desc))
    end

    def banners
      BannerItem.where.not(web_params: nil).each do |banner_item|
        if banner_item.web_params
          web_params = JSON.parse(banner_item.web_params).with_indifferent_access
          @main_offer = banner_item if web_params[:type] == 'main'
        end
        break if @main_offer
      end
    end
  end
end

module Storefront
  class StaticPagesController < StorefrontController
    before_action :authenticate_user!

    def show; end

    def privacy_policy; end

    def support; end

    def delivery; end

    def terms_and_conditions; end

    def faq; end
  end
end

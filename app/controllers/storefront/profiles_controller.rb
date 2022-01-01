module Storefront
  class ProfilesController < StorefrontController
    before_action :authenticate_user!

    def edit; end

    def update
      if current_user.update(user_params)
        redirect_to storefront_profile_path(current_user),
                    notice: t('messages.flash.profiles.successfully_updated_user_profile')
      else
        Rails.logger.info(current_user.errors.messages.inspect)
        render :edit
      end
    end

    def show; end

    private

    def user_params
      params.require(:user).permit(
        :mobile,
        :name
      )
    end
  end
end

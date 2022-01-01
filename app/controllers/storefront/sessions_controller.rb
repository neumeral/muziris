module Storefront
  class SessionsController < StorefrontController
    def new; end

    def create
      user = User.find_by(mobile: login_params[:mobile]) if login_params[:mobile]
      user ||= User.find_by(email: login_params[:email]) if login_params[:email]

      flash.now[:error] = t('messages.flash.session.not_found') && return unless user
      unless valid_params?
        flash.now[:error] = t('messages.flash.register.invalid_credentials') &&
                            return
      end

      if !login_params[:otp]
        status = user.generate_otp_and_notify
        if status != 'failure'
          redirect_to otp_storefront_sessions_path(session: login_params)
        else
          flash.now[:error] = t('messages.flash.common_error_message.something_went_wrong')
          redirect_back fallback_location: storefront_home_path
        end
      elsif user.verify_otp_and_save(login_params[:otp])
        token_reset_and_user_login(user)
      else
        flash.now[:error] = t('messages.flash.session.invalid_credentials')
        nil
      end
    end

    def otp
      @login_params = params[:session]
    end

    private

    def login_params
      params.require(:session).permit(:mobile, :email, :password, :otp, :valid_till)
    end

    def valid_params?
      login_params != nil
    end

    def token_reset_and_user_login(user)
      user.regenerate_authentication_token
      sign_in(user)
      redirect_to storefront_home_path
    end
  end
end

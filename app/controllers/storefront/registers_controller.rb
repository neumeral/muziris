# frozen_string_literal: true

module Storefront
  class RegistersController < StorefrontController
    def new; end

    def create
      user = User.find_by(email: register_params[:email]) if register_params[:email]
      user ||= User.find_by(mobile: register_params[:mobile]) if register_params[:mobile]
      unless valid_params?
        flash.now[:error] = t('messages.flash.register.invalid_credentials')
        return
      end

      unless user
        email = register_params[:email] if register_params[:email]
        email ||= "user_#{SecureRandom.hex}@lvh.me"
        mobile = register_params[:mobile] if register_params[:mobile]
        password = register_params[:set_password]
        password ||= SecureRandom.hex
        user = User.new(
          email: email, mobile: mobile, password: password,
          password_confirmation: password, active: false
        )
        unless user.save
          flash.now[:error] = t('messages.flash.register.invalid_credentials')
          return
        end
      end

      if !register_params[:otp]
        status = user.generate_otp_and_notify
        if status != 'failure'
          redirect_to otp_storefront_registers_path(register: register_params)
        else
          flash.now[:error] = t('messages.flash.common_error_message.something_went_wrong')
          redirect_back fallback_location: storefront_home_path
        end
      elsif user.verify_otp_and_save(register_params[:otp])
        user.regenerate_authentication_token
        activate_user(user)
        sign_in(user)
        redirect_to storefront_home_path

      elsif user.destroy
        flash.now[:error] = t('messages.flash.register.invalid_otp')
        redirect_back fallback_location: storefront_home_path
      else
        flash.now[:error] = t('messages.flash.common_error_message.something_went_wrong')
        redirect_back fallback_location: storefront_home_path
      end
    end

    def otp
      @register_params = params[:register]
    end

    private

    def register_params
      params.require(:register).permit(:name, :mobile, :email, :set_password, :otp, :valid_till)
    end

    def valid_params?
      register_params[:email] != ''
    end

    def activate_user(user)
      user.active = true
      user.save
    end
  end
end

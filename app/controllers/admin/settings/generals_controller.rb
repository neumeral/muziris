module Admin
  module Settings
    class GeneralsController < AdminController
      before_action :currencies, only: :index
      before_action :set_app_setting, only: :update

      def index; end

      def update
        if AppSetting.instance.update(general_settings_params)
          flash[:success] = 'Updates are saved'
        else
          flash[:error] = 'Something went wrong'
        end
        redirect_back fallback_location: root_path
      end

      private

      def currencies
        countries = ISO3166::Country.all
        @currencies = []
        countries.each do |country|
          country_code = country.alpha2
          country_name = ISO3166::Country[country_code]
          @currencies << country_name.currency if country_name.currency
        end
      end

      def set_app_setting
        @app_setting = AppSetting.find(params[:id])
      end

      def general_settings_params
        params.require(:settings).permit(:currency, :text_direction)
      end
    end
  end
end

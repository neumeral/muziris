# frozen_string_literal: true

module Api::V1
  class ProfilesController < ApiController
    def update
      if current_user.update(user_params)
        render_json(current_user)
      else
        render_json
      end
    end

    def show
      render_json(current_user)
    end

    private

    def render_json(value = nil)
      if value
        serializer = UserSerializer.new(value)
        render json: serializer
      else
        render json: nil
      end
    end

    def user_params
      params.require(:profile).permit(
        :mobile,
        :name
      )
    end
  end
end

class BannerItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :image_url, :web_params, :mobile_params
end

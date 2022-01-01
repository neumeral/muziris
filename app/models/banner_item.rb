class BannerItem < ApplicationRecord
  validates :title, :image_url, presence: true
end

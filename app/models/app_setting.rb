# frozen_string_literal: true

class AppSetting < ApplicationRecord
  def self.instance
    AppSetting.first || AppSetting.new
  end
end

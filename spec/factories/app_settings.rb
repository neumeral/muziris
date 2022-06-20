# frozen_string_literal: true

FactoryBot.define do
  factory :app_setting do
    currency { 'INR' }
    text_direction { 'ltr' }
  end
end

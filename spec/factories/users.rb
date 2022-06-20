# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'yadu' }
    email { 'user@example.com' }
    password { 'password' }
    admin { true }
  end
end

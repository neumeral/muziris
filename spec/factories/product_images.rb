FactoryBot.define do
  factory :product_image do
    association :product, factory: :product
    main { false }
  end
end

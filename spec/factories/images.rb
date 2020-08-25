FactoryBot.define do

  factory :image do
    image            {File.open("#{Rails.root}/spec/test_image.jpg")}
    association :item
  end
end
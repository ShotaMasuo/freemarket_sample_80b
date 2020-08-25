FactoryBot.define do
  
  factory :image do
    image {File.open("#{Rails.root}/spec/test_image.jpeg")}
    association :item
  end

end
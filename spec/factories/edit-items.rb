FactoryBot.define do

  factory :item do
    name          {"beef"}
    detail        {"test"}
    condition     {1}
    price         {1000}
    fee           {1}
    prefecture    {1}
    delivery_date {1}
    association :user
    association :category
  end

end
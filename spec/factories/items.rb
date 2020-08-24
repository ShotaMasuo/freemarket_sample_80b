FactoryBot.define do

  factory :item do
    name              {"abe"}
    detail            {"aaa"}
    category_id       {"1"}
    condition         {1}
    fee               {1}
    prefecture        {"aaa"}
    delivery_date     {1}
    price             {"111"}
    association :user

  end
end
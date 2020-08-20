FactoryBot.define do

  factory :address do
    first_name              {"abe"}
    family_name             {"tarou"}
    first_name_kana         {"abe"}
    family_name_kana        {"tarou"}
    post_code               {"000-0000"}
    prefecture_code         {"1"}
    city                    {"yokohama"}
    town                    {"1"}
  end

end
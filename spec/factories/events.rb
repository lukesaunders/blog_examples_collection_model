FactoryGirl.define do
  sequence :event_name do |n|
    "The Event #{n}"
  end

  factory :event do
    name { FactoryGirl.generate :event_name }
  end
end

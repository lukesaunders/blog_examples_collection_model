FactoryGirl.define do
  sequence :job_name do |n|
    "The Job #{n}"
  end

  factory :job do
    name { FactoryGirl.generate :job_name }
    event { FactoryGirl.create(:event) }
  end
end

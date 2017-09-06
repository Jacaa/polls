FactoryGirl.define do
  factory :poll do
    question "What's your favourite color?"
    answers [ "blue", "green" ]
    
    factory :invalid_poll do
      answers [ "","" ]
    end
  end
end
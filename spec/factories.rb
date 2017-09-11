FactoryGirl.define do
  factory :poll do
    question "What's your favourite color?"
    answers [ "blue", "green" ]
    allow_multiple false
    
    factory :invalid_poll do
      answers [ "","" ]
    end
    
    factory :poll_with_results do
      answers_with_values {{ "blue": 3, "green": 2}}
    end

    factory :poll_allow_multiple do
      allow_multiple true
    end
  end
end
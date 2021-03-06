FactoryGirl.define do
  factory :poll do
    question "What's your favourite color?"
    answers [ "blue", "green" ]
    allow_multiple false
    allow_duplication false
    
    factory :invalid_poll do
      answers [ "","" ]
    end
    
    factory :poll_allow_multiple do
      allow_multiple true
    end

    factory :poll_allow_duplication do
      allow_duplication true
    end
  end
end
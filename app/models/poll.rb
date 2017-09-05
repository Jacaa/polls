class Poll < ApplicationRecord

  validates :question, presence: true, 
                       length: { maximum: 255 }

  validates :answers, presence: true,
                      length: { minimum: 2 }
  
end

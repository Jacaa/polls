class Poll < ApplicationRecord

  serialize :answer, JSON

  validates :question, presence: true, 
                       length: { maximum: 255 }

  validates :answer, presence: true,
                     length: { minimum: 2 }
end

class Poll < ApplicationRecord

  validates :question, presence: true, length: { maximum: 255 }

  validate :number_of_non_empty_answers, :too_long_answers

  def number_of_non_empty_answers
    self.answers.map!(&:squish).delete('')
    if self.answers.length < 2
      error_message = "At least two possible answers are required"
      errors.add(:answers, error_message)
    end
  end

  def too_long_answers
    self.answers.each do |answer|
      error_message = "Answer is too long (maximum is 255 characters)"
      errors.add(:answers, error_message) if answer.length > 255
    end
  end
end

class Poll < ApplicationRecord
  before_create { create_answers_with_default_values }

  validates :question, presence: true, length: { maximum: 255 }

  validate :number_of_non_empty_different_answers, :too_long_answers

  def number_of_non_empty_different_answers
    self.answers.map!(&:squish).delete('') # Delete blank and empty answers
    self.answers = self.answers.uniq       # Delete repeated answers
    if self.answers.length < 2
      error_message = "At least two different answers are required"
      errors.add(:answers, error_message)
    end
  end

  def too_long_answers
    self.answers.each do |answer|
      error_message = "Answer is too long (maximum is 255 characters)"
      errors.add(:answers, error_message) if answer.length > 255
    end
  end

  def create_answers_with_default_values
    self.answers_with_values = {}
    self.answers.each do |answer|
      self.answers_with_values[answer] = 0
    end
  end

  def sort_answers_by_values
    self.answers_with_values = self.answers_with_values.sort_by { |k, v| v }.reverse.to_h
  end
end

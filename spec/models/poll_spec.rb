require 'rails_helper'

RSpec.describe Poll do
  
  subject(:poll) { Poll.new(question: "What's your favourite color?",
                            answer: { blue: 10, green: 5})}

  it "is valid with valid attributes" do
    expect(poll).to be_valid
  end

  it "is not valid without a question" do
    poll.question = nil
    expect(poll).to_not be_valid
  end
  
  it "is not valid with question longer than 255" do
    poll.question = "a" * 256
    expect(poll).to_not be_valid
  end

  it "is not valid without an answer" do
    poll.answer = nil
    expect(poll).to_not be_valid
  end

  it "is not valid if answer's Hash length is less than 2" do
    poll.answer = { blue: 10 }
    expect(poll).to_not be_valid
  end
  
  it "answer attribute should be saved as Hash" do
    poll.save
    expect(poll.reload.answer).to be_a(Hash)
  end
end

require "rails_helper"

RSpec.feature "Poll management" do

  scenario "User creates a new valid poll" do
    visit "/"
    fill_in "poll_question", with: "What's you favourite color?"
    fill_in "poll_answers_1", with: "Blue"
    fill_in "poll_answers_2", with: "Green"
    click_button "Create poll"
    expect(page).to have_text("Poll was successfully created.")
  end

  scenario "User creates a new invalid poll" do
    visit "/"
    fill_in "poll_question", with: ""
    click_button "Create poll"
    expect(page).to have_text("Please review the problems below:")
  end
end
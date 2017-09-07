require "rails_helper"

RSpec.feature "Poll management - User" do

  scenario "creates a new valid poll" do
    visit "/"
    fill_in "poll_question", with: "What's you favourite color?"
    fill_in "poll_answers_1", with: "Blue"
    fill_in "poll_answers_2", with: "Green"
    click_button "Create poll"
    expect(page).to have_text("Poll was successfully created.")
  end

  scenario "creates a new invalid poll", js: true do
    visit "/"
    fill_in "poll_question", with: ""
    click_button "Create poll"
    expect(page).to have_text("Question can't be blank")
  end
end
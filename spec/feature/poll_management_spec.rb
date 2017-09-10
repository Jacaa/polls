require "rails_helper"

RSpec.feature "Poll management - User" do

  describe "creates" do
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

  describe "votes" do

    before(:each) do
      @poll = FactoryGirl.create(:poll)
    end

    scenario "votes for one answer" do
      visit "/#{@poll.id}/voting"
      choose "poll_answers_blue"
      click_button "Vote"
      expect(page).to have_text("blue 1")
    end

    scenario "votes for nothing", js: true do
      visit "/#{@poll.id}/voting"
      click_button "Vote"
      expect(page).to have_text("You need to choose an answer")
    end
  end
end
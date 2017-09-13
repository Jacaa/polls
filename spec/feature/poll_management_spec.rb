require "rails_helper"

RSpec.feature "Poll management - User" do

  describe "creates" do
    scenario "a new valid poll" do
      visit "/"
      fill_in "poll_question", with: "What's you favourite color?"
      fill_in "poll_answers_1", with: "Blue"
      fill_in "poll_answers_2", with: "Green"
      click_button "Create poll"
      expect(page).to have_selector("form.edit_poll")
    end

    scenario "a new invalid poll", js: true do
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

    scenario "for one answer" do
      visit "/#{@poll.id}/voting"
      choose "poll_answers_blue"
      click_button "Vote"
      expect(page).to have_text("blue 1")
      # Try to vote again
      visit "/#{@poll.id}/voting"
      choose "poll_answers_blue"
      click_button "Vote"
      expect(page).to have_text("You have already voted!")
    end

    scenario "for nothing", js: true do
      visit "/#{@poll.id}/voting"
      click_button "Vote"
      expect(page).to have_text("You need to choose an answer")
    end

    scenario "for multiple answers" do
      poll = FactoryGirl.create(:poll_allow_multiple)
      visit "/#{poll.id}/voting"
      check "poll_answers_blue"
      check "poll_answers_green"
      click_button "Vote"
      expect(page).to have_text("blue 1")
      expect(page).to have_text("green 1")
    end

    scenario "multiple times" do
      poll = FactoryGirl.create(:poll_allow_duplication)
      (1..5).to_a.each do |i|
        visit "/#{poll.id}/voting"
        choose "poll_answers_blue"
        click_button "Vote"
        expect(page).to have_text("blue #{i}")
      end
    end
  end
end
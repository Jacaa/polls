class HomeController < ApplicationController
  
  # Set the @poll with new Poll instance with two empty possible answers,
  # so that the appropriate form will be displayed
  # If the answers will be 'answers: []' then no form will be displayed
  # based on app/inputs/array_input.rb
  def index
    @poll = Poll.new(answers: ['',''])
  end
end

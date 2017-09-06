class PollsController < ApplicationController

  # POST /polls
  def create
    @poll = Poll.new(poll_params)
    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
      else
        format.js
      end
    end
  end

  # GET /polls/:id
  def show
    @poll = Poll.find(params[:id])
  end

  private

    def poll_params
      params.require(:poll).permit(:question, answers: [])
    end
end

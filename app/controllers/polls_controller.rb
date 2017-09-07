class PollsController < ApplicationController

  # POST /polls
  def create
    @poll = Poll.new(poll_params)
    respond_to do |format|
      if @poll.save
        notice = 'Poll was successfully created.'
        format.html { redirect_to edit_poll_path(@poll), notice: notice }
      else
        format.js
      end
    end
  end

  # GET /polls/:id
  def show
    @poll = Poll.find(params[:id])
  end
  
  # GET /polls/:id/edit
  def edit
    @poll = Poll.find(params[:id])
  end
  private

    def poll_params
      params.require(:poll).permit(:question, answers: [])
    end
end

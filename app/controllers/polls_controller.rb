class PollsController < ApplicationController

  # POST /polls
  def create
    @poll = Poll.new(poll_params)
    # puts @poll.answer.count
    puts @poll.answers
    # puts @poll.valid?
    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
      else
        format.html { render 'home/index' }
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

class PollsController < ApplicationController
  before_action :set_poll, only: [:edit, :show, :update]

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
  end
  
  # GET /polls/:id/edit
  def edit
  end
  
  # PATCH /polls/:id
  def update
    choosen_answer = params[:poll][:answers]
    respond_to do |format|
      if choosen_answer.empty?
        @poll.errors.add(:answers, "You need to choose an answer")
        format.js
      else
        @poll.answers_with_values[choosen_answer] += 1
        @poll.save
        format.html { redirect_to @poll }
      end
    end
  end

  private
    def set_poll
      @poll = Poll.find(params[:id])
    end

    def poll_params
      params.require(:poll).permit(:question, answers: [])
    end
end

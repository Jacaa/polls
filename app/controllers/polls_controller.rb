class PollsController < ApplicationController
  include PollsHelper

  before_action :set_poll, only: [:edit, :show, :update]
  before_action :check_duplication, only: :update
  # POST /polls
  def create
    @poll = Poll.new(poll_params)
    respond_to do |format|
      if @poll.save
        notice = 'Poll was successfully created.'
        format.html { redirect_to voting_path(@poll), notice: notice }
      else
        format.js { render partial: "errors" }
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
    choosen_answers = normalize params[:poll][:answers]
    respond_to do |format|
      if choosen_answers.empty?
        @poll.errors.add(:answers, "You need to choose an answer")
        format.js { render partial: "errors" }
      else
        choosen_answers.each { |answer| @poll.answers_with_values[answer] += 1 }
        @poll.save
        format.html { redirect_to results_path(@poll) }
      end
    end
  end

  private
    def set_poll
      @poll = Poll.find(params[:id])
    end

    def poll_params
      params.require(:poll).permit(:question, 
                                   :allow_multiple, 
                                   :allow_duplication, 
                                   answers: [])
    end

    def check_duplication
      unless @poll.allow_duplication
        user_ip = request.remote_ip
        if @poll.list_of_ip.include?(user_ip)
          @poll.errors.add(:answers, "You have already voted!")
          render partial: "errors"
        else
          @poll.list_of_ip << user_ip
        end
      end
    end
end

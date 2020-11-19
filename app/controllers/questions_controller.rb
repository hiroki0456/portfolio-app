class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  # move_to_index, only: [:new]
  def index
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to root_path
    else
      render :new
    end
  end

  def confirm
  end

  private

  def question_params
    params.require(:question).permit(:category_id, :title, :question).merge(user_id: current_user.id)
  end

  def move_to_index
    # redirect_to 
  end
end

class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_question, only: [:show, :like]
  # move_to_index, only: [:new]
  def index
    @questions = Question.order(created_at: "desc").limit(5)
  end

  def question_all
    @questions = Question.page(params[:page]).per(10)
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

  def show
    @comment = Comment.new
  end

  def search
    @questions = Question.search(params[:search]).page(params[:page]).per(10)
  end

  def category_search
    @category = Category.find(params[:category_id])
    @questions = @category.questions.page(params[:page]).per(10)
  end

  private

  def question_params
    params.require(:question).permit(:category_id, :title, :question).merge(user_id: current_user.id)
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def move_to_index
    # redirect_to 
  end
end

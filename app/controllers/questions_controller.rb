class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_question, only: [:show, :like]
  before_action :move_to_index, only: [:new, :create]
  before_action :comment_redirect_to_root, only: [:for_reply]

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
    @categories =  Category.all.to_ary.drop(1)
    @questions = @category.questions.page(params[:page]).per(10)
  end

  def for_reply
    @questions = Question.order(created_at: "desc").page(params[:page]).per(10)
    @categories =  Category.all.to_ary.drop(1)
  end

  private

  def question_params
    params.require(:question).permit(:category_id, :title, :question).merge(user_id: current_user.id)
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if user_signed_in? && current_user.philosopher
  end

  def comment_redirect_to_root
    redirect_to root_path if user_signed_in? && !current_user.philosopher
  end
end

class CommentsController < ApplicationController
  before_action :set_question
  before_action :authenticate_user!

  def index
    question = Question.find(params[:question_id])
    @comments = question.comments.includes(:user)
    # binding.pry
    render 'index', formats: :json, handlers: 'jbuilder'
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render 'create', formats: :json, handlers: 'jbuilder'
    else
      flash[:notice] = "回答の投稿に失敗しました"
      redirect_to question_path(@question)
    end
  end

  def edit
  end

  def find_like
    render json: Like.filter_by_like(params[:comment_id]).select(:id, :user_id, :comment_id)
  end

  def like
    like = Like.new(like_params)
    if like.save
      head :created
    else
      flash[:notice] = "失敗しました"
      redirect_to question_path(@question)
    end
  end

  private

  def comment_params
    params.permit(:comment, :title).merge(user_id: current_user.id, question_id: params[:question_id])
  end

  def like_params
    {user_id: current_user.id, comment_id: params[:id]}
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end

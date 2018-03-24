class AnswersController < ApplicationController

  def create
    @answer = Answer.new
    @question = Question.find(params[:question_id])
    @answer.question_id = @question.id
    @answer.text = ""
    @answer.save
  end

  private
    def answer_params
      params.require(:answer).permit(:text, :correct_answer, :question_id)
    end

end
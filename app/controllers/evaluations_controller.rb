class EvaluationsController < ApplicationController

  def show
    @evaluation = Evaluation.find(params[:id])
    @questions = Question.where('evaluation_id = ?', @evaluation.id )
  end

end
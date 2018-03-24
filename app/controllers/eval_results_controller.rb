class EvalResultsController < ApplicationController

  def create
    @eval_result = EvalResult.new(eval_result_params)
    @eval_result.user = current_user

    respond_to do |format|
      if @eval_result.save
        format.html { redirect_to @eval_result, notice: 'The eval_result was successfully created.' }
        format.json { render :show, status: :created, location: @eval_result }
      else
        format.html { render :new }
        format.json { render json: @eval_result.errors, status: :unprocessable_entity }
      end
    end
  end


  def eval_result_params
    params.require(:eval_result).permit(:score, :user_id, :evaluation_id)
  end

end
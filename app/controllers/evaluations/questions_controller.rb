class Evaluations::QuestionsController < ApplicationController
  before_action :set_question, only: [:edit, :update, :destroy]

  def new
    @evaluation = Evaluation.find(params[:evaluation_id])
    @question = @evaluation.questions.build
    @question.answers.build
  end

  def edit
    @evaluation = Evaluation.find(params[:evaluation_id])
    @answers = @question.answers.order('created_at DESC')
  end

  def create
    @evaluation = Evaluation.find(params[:evaluation_id])
    @question = Question.new(question_params)
    @question.evaluation_id = @evaluation.id

    respond_to do |format|
      if @question.save
        format.html { redirect_to edit_evaluation_question_path(@evaluation, @question) }
        format.json { render :show, status: :created, location: @question }
        format.js  
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    @evaluation = Evaluation.find(params[:evaluation_id])
    
    respond_to do |format|
      if @question.update(question_params)
        format.js
        format.html { redirect_to edit_evaluation_question_path(@evaluation, @question), notice: 'The question was successfully updated.' }
        format.json { render :show, status: :ok, location: @evaluation }
 
      else
        format.html { render :edit }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @evaluation = Evaluation.find(params[:evaluation_id])

    respond_to do |format|
      if @question.destroy
        format.html { redirect_to @evaluation, info: "The question was deleted successfully." }
        format.js
      else
        format.html { render :show, flash[:error] = "There was an error deleting the question." }
        format.js
      end
    end  
  end

  def sort 
    params[:question].each_with_index do |id, index|
      Question.where(id: id).update_all(position: index + 1)
    end 
    head :ok
  end 

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:text, :evaluation_id, answers_attributes: [:id, :text, :correct_answer, :question_id, :_destroy])
    end



end
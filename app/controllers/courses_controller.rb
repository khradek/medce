class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit] 
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @q = Course.where('published = ?', true ).search(params[:q])
    @courses = @q.result.order("title").paginate(:page => params[:page], :per_page => 5)
    @authors = User.where('author = ?', true ).order('last_name ASC')
    @order_item = current_order.order_items.new
    if current_user
      @purchased_courses = current_user.purchased_courses
    else
      @purchased_courses = []
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find params[:id]
    @author = @course.user
    @order_item = current_order.order_items.new
    if current_user
      @purchased_courses = current_user.purchased_courses
    else
      @purchased_courses = []
    end
    @categories = [@course.category1, @course.category2, @course.category3, @course.category4, @course.category5, @course.category6].reject(&:blank?)
    @evaluation = @course.evaluation
    if current_user.nil?
      @results = []
    else
      @results = EvalResult.where(course_id: @course.id, user_id: current_user.id).order('created_at DESC')
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@course.title}",
               template: "courses/show.pdf.erb",
               locals: {:course => @course},
               margin: {top:        20,    # default 10 (mm)
                        bottom:     20,
                        left:       20,
                        right:      20 }             
      end
    end
  end

  def preview
    @course = Course.find params[:course_id]
    @number = @course.preview_num
    if @course.body.blank?
      @preview = @course.body
    else
      @preview = @course.body[0..@number]
    end

    respond_to do |format|
      format.pdf do
        render pdf: "#{@course.title}",
               template: "courses/preview.pdf.erb",
               locals: {:course => @course},
               margin: {top:        20,    # default 10 (mm)
                        bottom:     20,
                        left:       20,
                        right:      20 }             
      end
    end
  end

  def take_evaluation
    @course = Course.find params[:course_id]
    @evaluation = Evaluation.find_by('course_id = ?', @course.id)
    @questions = @evaluation.questions.order(:position) 
  end

  def grading
    @course ||= Course.find params[:course_id]
    @evaluation = Evaluation.find_by('course_id = ?', @course.id)
    total = @evaluation.questions.count.to_i

    session[:total]   = total
    session[:correct] = 0
    @total   = session[:total]

    h = params[:answer]

    h.values.each do |answer|
      @answer = answer ? Answer.find(answer) : nil
      if @answer and @answer.correct_answer
        @correct = true
        session[:correct] += 1
      else
        @correct = false
      end
    end

    @correct = session[:correct]
    @total   = session[:total]

    @score = @correct * 100 / @total

    @eval_result = EvalResult.new(user_id: current_user.id, course_id: @course.id, score: @score)
    @eval_result.save

    redirect_to course_results_path
  end

  def results
    @course = Course.find params[:course_id]
    @correct = session[:correct]
    @total   = session[:total]

    @score = @correct * 100 / @total 
  end

  # GET /courses/new
  def new
    @course = current_user.courses.build
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    @course.user = current_user

    respond_to do |format|
      if @course.save
        format.html { redirect_to edit_course_path(@course), notice: 'The class was successfully created. Please be sure to add an evaluation to the class by clicking the Class Evaluation button below.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'The class was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'The class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    def correct_user
      redirect_to root_path, notice: "You can only edit classes that you authored." if @course.user != current_user   
    end 

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:title, :body, :preview_num, :req_score, :author_id, :description, :ce_hours, :price, :category1, :category2, :category3, :category4, :category5, :category6, :published)
    end

end

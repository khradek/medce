class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @q = Course.search(params[:q])
    @courses = @q.result.order("title").paginate(:page => params[:page], :per_page => 5)
    @authors = User.where('author = ?', true )
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find params[:id]
    @author = @course.user

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
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
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
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
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
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:title, :body, :author_id, :description, :ce_hours, :price, :category1, :category2, :category3, :category4, :category5)
    end
end

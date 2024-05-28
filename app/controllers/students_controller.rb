class StudentsController < ApplicationController

  before_action :require_teacher, only: [:show, :new, :create, :destroy]

  def new
    @student = Student.new
  end

  def create

    puts "student_params: #{student_params}"
    puts "session id: #{session[:teacher_id]}"
    @student = Student.new(student_params)
    if @student.save
      redirect_to teachers_path, notice: "Student created successfully"
    else
      render :new , notice: "Student not created"
    end
  end

  def show
    @student = Student.find_by(id: params[:id])

    if @student.nil?
      redirect_to students_path, alert: "Student not found"
    end
  end

  def update
  end

  def index
    @articles = Article.where(teacher_id: current_student.teacher_id)
  end

  def destroy
    @student = Student.find_by(id: params[:id])
    if @student.nil?
      redirect_to teachers_path, alert: "Student not found"
    else
      @student.destroy
      redirect_to teachers_path, notice: "Student deleted successfully"
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :email, :password, :password_confirmation, :teacher_id)
  end
end

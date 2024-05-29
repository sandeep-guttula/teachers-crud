class TeachersController < ApplicationController

  before_action :require_teacher, only: [:show, :edit, :update, :destroy, :index]

  before_action :check_teacher_session, only: [:index]

  def index
    @teachers = Teacher.all
    if session[:teacher_id]
      @teacher = Teacher.find_by(id: TeacherActiveSession.find_by(session_id: session[:teacher_id]).teacher_id)
      @students = Student.where(teacher_id: @teacher.id)
    end
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      session_id = SecureRandom.uuid
      @teacher_session = TeacherActiveSession.new(teacher_id: @teacher.id, session_id: session_id, status: "active", session_expiry: 15.minutes.from_now)
      @teacher_session.save
      session[:teacher_id] = session_id
      redirect_to teachers_path, notice: "Teacher created successfully"
    else
      render :new
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def update
    @teacher = Teacher.find(params[:id])
    if @teacher.update(teacher_params)
      redirect_to @teacher, notice: "Teacher updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    redirect_to teachers_path, notice: "Teacher deleted successfully"
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :email, :password, :password_confirmation)
  end
end

class TeachersController < ApplicationController

  # before_action :require_teacher, only: [:show, :edit, :update, :destroy, :index, :new, :create]

  def index
    @teachers = Teacher.all
    @students = Student.where(teacher_id: current_teacher.id)
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      session[:teacher_id] = @teacher.id
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

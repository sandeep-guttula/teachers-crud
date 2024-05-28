class StudentSessionsController < ApplicationController
  def new
  end

  def create

    if session[:teacher_id] != nil
      session[:teacher_id] = nil
    end

    @student = Student.find_by(email: params[:email])
    if @student && @student.authenticate(params[:password])
      session[:student_id] = @student.id
      redirect_to students_path, notice: "You have successfully signed in!"
    else
      flash.now[:alert] = "Wrong email or password. Please try again."
      render :new
    end

  end

  def destroy
    session[:student_id] = nil
    redirect_to new_teacher_session_path, notice: "You have successfully signed out!"
  end
end

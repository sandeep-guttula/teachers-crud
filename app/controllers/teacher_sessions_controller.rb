class TeacherSessionsController < ApplicationController

  before_action :check_teacher_session, only: [:new, :create]

  def new

  end

  def create
    teacher = Teacher.find_by(email: params[:email])
    if teacher && teacher.authenticate(params[:password])
      session_id = SecureRandom.uuid
      @teacher_session = TeacherActiveSession.new(teacher_id: teacher.id, session_id: session_id, status: "active", session_expiry: 15.minutes.from_now)
      @teacher_session.save
      session[:teacher_id] = session_id
      # session[:teacher_id] = teacher.id
      redirect_to teachers_path, notice: "Logged in successfully"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    if session[:teacher_id]
      TeacherActiveSession.find_by(session_id: session[:teacher_id]).update(status: "inactive")
      session[:teacher_id] = nil
    end

    redirect_to new_teacher_path , notice: "Logged out successfully"
  end
end

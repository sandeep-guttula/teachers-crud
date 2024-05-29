class ApplicationController < ActionController::Base


  protect_from_forgery with: :exception

  before_action :check_teacher_session

  helper_method :current_teacher
  helper_method :current_student

  def current_teacher
    # @current_teacher ||= Teacher.find(session[:teacher_id]) if session[:teacher_id]
    if session[:teacher_id]
      if TeacherActiveSession.where(session_id: session[:teacher_id], status: "active").exists?
        @current_teacher ||= Teacher.find(TeacherActiveSession.find_by(session_id: session[:teacher_id]).teacher_id)
      else
        session[:teacher_id] = nil
        @current_teacher = nil
      end
    end
  end

  def require_teacher
    if current_teacher.nil?
      redirect_to new_teacher_session_path
    end
  end


  def require_student
    if current_student.nil?
      redirect_to new_student_session_path
    end
  end

  def current_student
    @current_student ||= Student.find(session[:student_id]) if session[:student_id]
  end


  def check_teacher_session
    if session[:teacher_id]
      current_teacher_session = TeacherActiveSession.find_by(session_id: session[:teacher_id])
      if current_teacher_session.session_expiry < Time.now
        current_teacher_session.update(status: "inactive")
        session[:teacher_id] = nil
        redirect_to new_teacher_session_path, alert: "Session expired. Please login again."
      end
    end
  end


end

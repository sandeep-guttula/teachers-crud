class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_teacher
  helper_method :current_student

  def current_teacher
    @current_teacher ||= Teacher.find(session[:teacher_id]) if session[:teacher_id]
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

end

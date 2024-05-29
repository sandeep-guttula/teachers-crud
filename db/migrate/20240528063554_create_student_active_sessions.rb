class CreateStudentActiveSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :student_active_sessions do |t|
      t.string :session_id
      t.references :student, null: false, foreign_key: true
      t.string :status
      t.datetime :session_expiry

      t.timestamps
    end
  end
end

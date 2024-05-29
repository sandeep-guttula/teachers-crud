class CreateUserActiveSessions < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :user_active_sessions, :teachers
    remove_foreign_key :user_active_sessions, :students
    remove_column :user_active_sessions, :teacher_id
    remove_column :user_active_sessions, :student_id

    # Add new polymorphic columns
    add_column :user_active_sessions, :user_id, :integer, null: false
    add_column :user_active_sessions, :role, :string, null: false

    # Add indices for the new columns
    add_index :user_active_sessions, [:user_id, :role]
  end
end

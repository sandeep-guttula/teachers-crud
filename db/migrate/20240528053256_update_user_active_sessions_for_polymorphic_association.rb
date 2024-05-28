class UpdateUserActiveSessionsForPolymorphicAssociation < ActiveRecord::Migration[7.1]
  def change
    change_table :user_active_sessions do |t|
      t.references :user, polymorphic: true, index: true

      t.remove :teacher_id
      t.remove :student_id
    end

    remove_foreign_key :user_active_sessions, :teachers
    remove_foreign_key :user_active_sessions, :students
  end
end

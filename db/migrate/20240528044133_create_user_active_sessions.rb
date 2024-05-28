class CreateUserActiveSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :user_active_sessions do |t|
      t.string :session_id
      t.references :teacher, null: true, foreign_key: true
      t.boolean :status
      t.references :student, null: true, foreign_key: true

      t.timestamps
    end
  end
end

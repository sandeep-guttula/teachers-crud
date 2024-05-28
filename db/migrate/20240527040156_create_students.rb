class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.references :teacher, null: false, foreign_key: true

      t.timestamps
    end
  end
end

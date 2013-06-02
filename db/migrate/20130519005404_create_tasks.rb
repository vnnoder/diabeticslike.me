class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :due_date
      t.integer :user_id
      t.boolean :completed
      t.integer :challenge_id
      t.timestamps
    end
  end
end

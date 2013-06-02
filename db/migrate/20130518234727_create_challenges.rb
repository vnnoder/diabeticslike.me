class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.text :description
      t.string :duration
      t.integer :owner_id
      t.timestamps
    end
  end
end

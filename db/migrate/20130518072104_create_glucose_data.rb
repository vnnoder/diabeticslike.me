class CreateGlucoseData < ActiveRecord::Migration
  def change
    create_table :glucose_data do |t|
      t.integer :user_id
      t.datetime :sensor_time
      t.integer :meter_value
      t.integer :sensor_value
      t.timestamps
    end
  end
end

require 'csv'
class GlucoseDatum < ActiveRecord::Base
  belongs_to :user
  MINIMUM = 82
  MAXIMUM = 110
  FLUCTUATE_THRESHOLD = 50
  NORMAL = 1
  ABNORMAL = 0
  LOW = 0
  NORMAL = 1
  HIGH = 2
  FLUCTUATE = 3
  NONE = 0


  def self.import_glucose_data(upload_file, user)
    CSV.parse(upload_file.read, :headers => true) do |row|
      mapping = { :meter_value => 'MeterValue', :sensor_value => 'SensorValue'}
      datum = GlucoseDatum.new
      mapping.each do |attr, mapkey|
        datum.send("#{attr}=", row[mapkey])
      end
      datum.sensor_time = DateTime.strptime(row['SensorDisplayTime'], "%m/%d/%y %H:%M")
      datum.user_id = user.id
      datum.save
    end

  end
end

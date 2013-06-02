class GlucoseDataController < InheritedResources::Base
  before_filter :authenticate_user!

  def index

  end

  def create
    if params[:glucose_datum]
      date = User::TO.to_date
      @glucose_datum = GlucoseDatum.new()
      @glucose_datum.user = current_user
      @glucose_datum.sensor_time = "#{date} #{params[:glucose_datum][:sensor_time]}"
      @glucose_datum.sensor_value = params[:glucose_datum][:sensor_value]
      @glucose_datum.save
    end
  end

  def import
    GlucoseDatum.import_glucose_data(params[:glucose_datum][:glucose_data_file], current_user)
    render :text => 'success'
  end
end

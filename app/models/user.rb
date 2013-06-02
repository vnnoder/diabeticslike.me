class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :authentications
  has_many :statuses
  has_many :challenges, :foreign_key => 'owner_id'
  has_many :glucose_data
  has_many :tasks

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :first_name, :last_name, :email, :phone_number, :password, :password_confirmation, :diabetes_type, :age

  #validates_format_of :phone_number, :with => /^[\d]{8}$/i, :on => :update

  FROM = '2011-06-23 14:30:00'
  TO = '2011-06-23 18:00:00'

  def get_glucose_data(from = FROM, to = TO)
    self.glucose_data.where(["sensor_time > ? and sensor_time < ?", from, to])
  end

  def variance(from = FROM, to = TO)
    values = self.glucose_data.where(["sensor_time > ? and sensor_time < ?", from, to]).map(&:sensor_value)
    return 0 if values.size <= 1
    muy = values.sum.to_f/values.size
    variance = values.inject(0) do |sum,value|
      delta = value - muy
      sum += delta * delta
    end
    Math.sqrt(variance.to_f / (values.size - 1)).round()
  end

  def average(from = FROM, to = TO)
    values = self.glucose_data.where(["sensor_time > ? and sensor_time < ?", from, to]).map(&:sensor_value)
    return 0 if values.size == 0
    (values.sum.to_f/values.size).round()
  end

  def glucose_assessment(from = FROM, to = TO)
    avg = average(from, to)
    var = variance(from, to)

    if avg < GlucoseDatum.MINIMUM
      return {:result => GlucoseDatum.ABNORMAL, :reason => GlucoseDatum.LOW}
    elsif avg > GlucoseDatum.MAXIMUM
      return {:result => GlucoseDatum.ABNORMAL, :reason => GlucoseDatum.HIGH}
    elsif var > FLUCTUATE_THRESHOLD
      return {:result => GlucoseDatum.ABNORMAL, :reason => GlucoseDatum.FLUCTUATE}
    else
      return {:result => GlucoseDatum.NORMAL, :reason => GlucoseDatum.NONE}
    end
  end

  def display_name
    first_name + ' ' + last_name
  end

  def image_url(width_height_param=nil)
    if width_height_param
      "https://graph.facebook.com/#{facebook_id}/picture?type=square&#{width_height_param}"
    else
      "https://graph.facebook.com/#{facebook_id}/picture?type=square"
    end
  end

  def apply_omniauth(omniauth)
    self.email = omniauth['info']['email'] if email.blank?
    self.first_name = omniauth['info']['first_name']
    self.last_name = omniauth['info']['last_name']
    self.phone_number = omniauth['info']['phone_number']
    if omniauth['provider'] == 'twitter'
      self.email = "twitter#{omniauth['uid']}@twitter.com"
    end
    self.confirmed_at = Time.now.utc
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end


  # Check if user connected social network
  def social_connected?(social_name)
    authentication_providers.include?(social_name)
  end


  def authentication_providers
    @authentication_providers ||= Authentication.where(:user_id => self.id).map(&:provider)
  end

  def facebook_id
    @facebook_id ||= Authentication.where(:user_id => self.id, :provider => 'facebook').first.try(:uid)
  end



end

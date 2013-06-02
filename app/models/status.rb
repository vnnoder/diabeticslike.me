class Status < ActiveRecord::Base


  belongs_to :user
  attr_accessible :message

  #include PublicActivity::Model
  #tracked owner: Proc.new{ |controller, model| controller.current_user }

end

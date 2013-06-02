class Challenge < ActiveRecord::Base
  attr_accessible :name, :duration, :description, :tasks_attributes, :owner
  belongs_to :owner, :class_name => 'User'
  has_many :tasks

  accepts_nested_attributes_for :tasks


end

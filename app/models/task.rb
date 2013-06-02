class Task < ActiveRecord::Base
  attr_accessible :title, :due_date, :user
  belongs_to :challenge
  belongs_to :user
end

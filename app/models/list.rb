class List < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  has_many :children, class_name: "Task"
  has_one :star, :as => :starable
  validates_presence_of :name, :user_id
  acts_as_paranoid
end

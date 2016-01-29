class List < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  has_one :star, :as => :starable
  validates_presence_of :name
end

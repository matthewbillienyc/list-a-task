class Task < ActiveRecord::Base
  belongs_to :list
  has_one :star, :as => :starable
  validates_presence_of :priority, :description
end

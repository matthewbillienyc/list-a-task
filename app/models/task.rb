class Task < ActiveRecord::Base
  belongs_to :list
  delegate :user, to: :list
  has_one :star, :as => :starable
  validates_presence_of :list_id, :priority, :description
end

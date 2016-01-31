class Task < ActiveRecord::Base
  belongs_to :list
  belongs_to :list_including_deleted, class_name: "List", foreign_key: 'list_id', with_deleted: true
  delegate :user, to: :list
  has_one :star, :as => :starable
  validates_presence_of :list_id, :priority, :description
  acts_as_paranoid
end

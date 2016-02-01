class Task < ActiveRecord::Base
  belongs_to :list
  belongs_to :list_including_deleted, class_name: "List", foreign_key: 'list_id', with_deleted: true
  delegate :user, to: :list
  has_one :star, :as => :starable, dependent: :destroy
  validates_presence_of :list_id, :priority, :description
  acts_as_paranoid

  def self.active_with_priority(priority)
    where(priority: priority)
  end

  def self.deleted_with_priority(priority)
    only_deleted.where(priority: priority)
  end

  def self.deleted_and_active_with_priority(priority)
    with_deleted.where(priority: priority)
  end

  def self.active_starred_tasks
    all.select { |task| task.star }
  end

  def self.search_all_description_like(keyword)
    with_deleted.where("description LIKE ?", "%#{keyword}%")
  end
end

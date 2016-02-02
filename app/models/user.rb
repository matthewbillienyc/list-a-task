class User < ActiveRecord::Base
  has_secure_password
  has_many :lists
  has_many :tasks, through: :lists
  validates_uniqueness_of :username
  validates_presence_of :username
  validates_presence_of :password_digest
  mount_uploader :avatar, AvatarUploader


  def has_avatar?
    !self.avatar.current_path.nil?
  end

  def lists_total
    lists.with_deleted.length
  end

  def tasks_total
    tasks.with_deleted.length
  end

  def total_starred_tasks
    Star.with_deleted.task.length
  end

  def total_starred_lists
    Star.with_deleted.list.length
  end

  def total_starred_items
    Star.with_deleted.length
  end

  def self.with_most_active_lists
    id = joins(:lists).select("users.id, COUNT(lists.user_id) AS num_lists").group(:id).order("num_lists DESC").limit(1).first
    find(id)
  end

  def self.with_most_total_lists
    id = List.with_deleted.select("lists.user_id, COUNT(lists.*) AS lists_for_user").group(:user_id).order("lists_for_user DESC").limit(1).first.user_id
    User.find(id)
  end

  def self.with_most_active_tasks
    joins(:lists, :tasks).select("users.*, COUNT(tasks.*) as num_tasks").group("users.id").order("num_tasks DESC").limit(1).first
  end
end

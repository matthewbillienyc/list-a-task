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
    Star.with_deleted.task.select { |star| star.find_user_including_deleted_records == self }.length
  end

  def total_starred_lists
    Star.with_deleted.list.select { |star| star.find_user_including_deleted_records == self }.length
  end

  def total_starred_items
    Star.with_deleted.select { |star| star.find_user_including_deleted_records == self }.length
  end
end

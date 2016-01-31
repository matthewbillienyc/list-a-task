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

  def total_starred_lists
    list_stars = Star.list.with_deleted
    starred_lists = list_stars.map { |star| List.with_deleted.find(star.starable_id) }
    @total_starred_lists = starred_lists.select { |list| list.user_id == self.id }.length
  end

  def total_starred_tasks
    task_stars = Star.task.with_deleted
    starred_tasks = task_stars.map { |star| Task.with_deleted.find(star.starable_id) }
    tasks_lists = starred_tasks.map { |task| List.with_deleted.find(task.list_id) }
    @total_starred_tasks = tasks_lists.select { |list| list.user_id == self.id }.length
  end

  def total_starred_items
    (@total_starred_lists || self.total_starred_lists) + (@total_starred_tasks || self.total_starred_tasks)
  end
end

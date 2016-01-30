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

  def self.total_lists_made
    sum(:lists_total)
  end

  def self.total_tasks_made
    sum(:tasks_total)
  end

  def self.total_items_starred
    sum(:stars_total)
  end
end

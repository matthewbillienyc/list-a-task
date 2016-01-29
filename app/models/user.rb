class User < ActiveRecord::Base
  has_secure_password
  has_many :lists
  has_many :tasks, through: :lists
  validates_uniqueness_of :username
  validates_presence_of :username
  validates_presence_of :password_digest

  mount_uploader :avatar, AvatarUploader

  def has_avatar?
    self.avatar.methods.include?(:image)
  end
end

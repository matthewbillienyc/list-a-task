class List < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_one :star, :as => :starable, dependent: :destroy
  validates_presence_of :name, :user_id
  acts_as_paranoid
end

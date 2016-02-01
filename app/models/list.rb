class List < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_one :star, :as => :starable, dependent: :destroy
  validates_presence_of :name, :user_id
  acts_as_paranoid

  def sort_tasks_by_priority
    order = ['low', 'medium', 'high']
    tasks.sort { |a, b| order.index(b.priority) <=> order.index(a.priority) }
  end

  def self.search_all_name_like(keyword)
    with_deleted.where("name LIKE ?", "%#{keyword}%")
  end

  def self.with_most_tasks
    joins(:tasks).select("lists.*, COUNT(tasks.*) AS num_tasks").group(:id).order("num_tasks DESC").limit(1).first
  end
end

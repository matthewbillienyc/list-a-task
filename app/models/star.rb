class Star < ActiveRecord::Base
  belongs_to :starable, :polymorphic => true
  acts_as_paranoid
  scope :list, -> { where(starable_type: "List") }
  scope :task, -> { where(starable_type: "Task") }

  def self.lists
    where(starable_type: "List")
  end

  def self.tasks
    where(starable_type: "Task")
  end
end

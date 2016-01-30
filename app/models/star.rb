class Star < ActiveRecord::Base
  belongs_to :starable, :polymorphic => true

  def self.lists
    where(starable_type: "List")
  end

  def self.tasks
    where(starable_type: "Task")
  end
end

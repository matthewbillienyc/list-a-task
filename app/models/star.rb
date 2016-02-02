class Star < ActiveRecord::Base
  belongs_to :starable, :polymorphic => true
  acts_as_paranoid
  scope :list, -> { where(starable_type: "List") }
  scope :task, -> { where(starable_type: "Task") }

  def find_user_including_deleted_records
    starable = find_starable_including_deleted
    if starable.class.name == "List"
      User.find(starable.user_id)
    else
      list = List.with_deleted.find(starable.list_id)
      User.find(list.user_id)
    end
  end

  def self.active_starred_tasks
    where(starable_type: "Task").length
  end

  def self.active_starred_lists
    where(starable_type: "List").length
  end

  def find_starable_including_deleted
    self.starable_type.constantize.with_deleted.find(self.starable_id)
  end
end

class CreateTaskServices
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def call
    task.list.user.tasks_total += 1
    task.list.user.save
  end
end

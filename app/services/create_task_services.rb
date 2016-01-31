class CreateTaskServices
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def call
    task.user.tasks_total += 1
    task.user.save
  end
end

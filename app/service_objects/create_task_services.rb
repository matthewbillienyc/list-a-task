class CreateTaskServices
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def call
    list = List.find(task.list_id)
    list.tasks_total += 1
    list.save
  end
end

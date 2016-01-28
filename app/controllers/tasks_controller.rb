class TasksController < ApplicationController
  def create
    @task = Task.new(task_params)
    if @task.save
      task_partial = render_to_string(partial: 'tasks/task', locals: {task: @task})
      render json: {task: @task, task_partial: task_partial}
    else
      render nothing: true
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task_id = @task.id
    @task.destroy
    render json: {task_id: @task_id}
  end

  private

    def task_params
      params.require(:task).permit(:description, :priority, :list_id)
    end
end

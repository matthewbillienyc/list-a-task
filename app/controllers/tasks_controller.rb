class TasksController < ApplicationController
  def create
    @task = Task.new(task_params)
    if @task.save
      CreateTaskServices.new(@task).call
      task_partial = render_to_string(partial: 'tasks/task', locals: {task: @task})
      render json: {task: @task, task_partial: task_partial}
    else
      invalid_task
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task_id = @task.id
    @task.destroy
    render json: {task_id: @task_id}
  end

  def edit_priority
    task = Task.find(params[:id])
    priority_partial = render_to_string(partial: 'edit_priority', locals: { task: task })
    render json: { priority_partial: priority_partial, task: task }
  end

  def edit_description
    task = Task.find(params[:id])
    description_partial = render_to_string(partial: 'edit_description', locals: { task: task })
    render json: { task: task, description_partial: description_partial }
  end

  def update
    task = Task.find(params[:id])
    task.update(task_params)
    if task.save
      render json: { task: task }
    else
      invalid_task
    end
  end

  private

    def task_params
      params.require(:task).permit(:description, :priority, :list_id)
    end

    def invalid_task
      flash[:danger] = "Description can't be blank"
      flash_partial = render_to_string(partial: 'shared/flash', locals: { flash: flash } )
      render json: { flash_partial: flash_partial }
    end
end

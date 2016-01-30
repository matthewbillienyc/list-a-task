class TasksController < ApplicationController
  def create
    @task = Task.new(task_params)
    if @task.save
      CreateTaskServices.new(@task).call
      task_partial = render_to_string(partial: 'tasks/task', locals: {task: @task})
      respond_to do |format|
        format.json { render json: {task: @task, task_partial: task_partial} }
        format.html { redirect_to user_path(current_user) }
      end
    else
      flash[:danger] = "Description can't be blank"
      flash_partial = render_to_string(partial: 'shared/flash', locals: { flash: flash } )
      respond_to do |format|
        format.json { render json: { flash_partial: flash_partial } }
        format.html { redirect_to user_path(current_user) }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task_id = @task.id
    @task.destroy
    respond_to do |format|
      format.json { render json: {task_id: @task_id} }
      format.html { redirect_to user_path(current_user) }
    end
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
      flash[:danger] = "Description can't be blank"
      flash_partial = render_to_string(partial: 'shared/flash', locals: { flash: flash } )
      render json: { flash_partial: flash_partial }
    end
  end

  private

    def task_params
      params.require(:task).permit(:description, :priority, :list_id)
    end
end

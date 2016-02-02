module AdminHelper
  def verify_admin
    unless logged_in? && (current_user.admin == true || session[:admin_id])
      flash[:danger] = "You do not have admin access"
      redirect_to root_url
    end
  end

  def return_current_user_to_admin
    if admin_masquerade?
      log_out
      session[:user_id] = session[:admin_id]
      session.delete(:admin_id)
    end
  end

  def check_search_options(params)
    results = { "lists" => nil, "tasks" => nil }
    params[:include].each do |key, value|
      model = key.capitalize.constantize
      results["#{key}s"] = render_to_string(partial: "#{key}_results", locals: { "#{key}s".to_sym => model.send("search_all_like", params[:keyword]) })
    end
    results
  end

  def list_stats
    {
      active: {
        most_tasks: List.active_with_most_tasks
      },
      all: {
        avg_tasks_per_list: List.average_tasks_per_list,
        most_common_name: {
          name: List.most_common_name.keys.first,
          count: List.most_common_name.values.first
        }
      }
    }
  end

  def user_stats
    {
      most_active_lists: User.with_most_active_lists,
      most_total_lists: User.with_most_total_lists,
      most_active_tasks: User.with_most_active_tasks
    }
  end

  def task_stats
    {
      active: {
        low: Task.active_with_priority("low").length,
        medium: Task.active_with_priority("medium").length,
        high: Task.active_with_priority("high").length
      },
      all: {
        low: Task.all_with_priority("low").length,
        medium: Task.all_with_priority("medium").length,
        high: Task.all_with_priority("high").length
      }
    }
  end
end

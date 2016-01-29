class ListsController < ApplicationController
  def create
    @list = List.new(list_params)
    set_user(@list)
    attempt_save(@list)
  end

  def destroy
    @list = List.find(params[:id])
    @list_id = @list.id
    @list.destroy
    render json: {list_id: @list_id}
  end

  private

    def list_params
      params.require(:list).permit(:name, :user_id)
    end

    def set_user(list)
      list.user_id = current_user.id
    end

    def attempt_save(list)
      if list.save
        CreateListServices.new(list).call
        render_partials_for_successful_save(list)
      else
        render_partials_for_invalid_list
      end
    end

    def render_partials_for_successful_save(list)
      list_partial = render_to_string(partial: 'lists/list', locals: { list: list })
      options_partial = render_to_string(partial: 'lists/dropdown_option', locals: { list: list })
      render json: { list: list, list_partial: list_partial, options_partial: options_partial }
    end

    def render_partials_for_invalid_list
      flash[:danger] = "Your list needs a name!"
      flash_partial = render_to_string(partial: 'shared/flash', locals: { flash: flash })
      render json: { flash_partial: flash_partial }
    end
end

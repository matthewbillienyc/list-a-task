class ListsController < ApplicationController
  def create
    @list = List.new(list_params)
    if @list.save
      list_partial = render_to_string(partial: 'lists/list', locals: {list: @list})
      dropdown_option = render_to_string(partial: 'lists/dropdown_option', locals: {list: @list})
      render json: {list: @list, list_partial: list_partial, options_partial: dropdown_option}
    else
      flash[:danger] = "Your list needs a name!"
      flash_partial = render_to_string(partial: 'shared/flash', locals: { flash: flash } )
      render json: { flash_partial: flash_partial }
    end
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
end

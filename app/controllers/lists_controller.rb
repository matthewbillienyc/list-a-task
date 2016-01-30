class ListsController < ApplicationController
  def create
    @list = List.new(list_params)
    if @list.save
      CreateListServices.new(@list).call
      list_partial = render_to_string(partial: 'lists/list', locals: {list: @list})
      dropdown_option = render_to_string(partial: 'lists/dropdown_option', locals: {list: @list})
      respond_to do |format|
        format.json { render json: {list: @list, list_partial: list_partial, options_partial: dropdown_option} }
        format.html { redirect_to user_path(current_user) }
      end
    else
      flash[:danger] = "Your list needs a name!"
      flash_partial = render_to_string(partial: 'shared/flash', locals: { flash: flash } )
      respond_to do |format|
        format.json { render json: { flash_partial: flash_partial } }
        format.html { redirect_to user_path(current_user) }
      end
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list_id = @list.id
    @list.destroy
    respond_to do |format|
      format.json { render json: {list_id: @list_id} }
      format.html { redirect_to user_path(current_user) }
    end
  end

  private

    def list_params
      params.require(:list).permit(:name, :user_id)
    end
end

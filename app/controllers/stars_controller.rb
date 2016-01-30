class StarsController < ApplicationController
  def create
    @star = Star.new(star_params)
    @star.save
    CreateStarServices.new(@star).call
    unstar_partial = render_to_string(partial: 'stars/unstar', locals: {star: @star})
    respond_to do |format|
      format.json { render json: {unstar_partial: unstar_partial, star: @star} }
      format.html { redirect_to user_path(current_user) }
    end
  end

  def destroy
    @star = Star.find(params[:id])
    starable = { id: @star.starable_id, type: @star.starable_type }
    star_partial = render_to_string(partial: 'stars/star', locals: {starable: @star.starable})
    @star.destroy
    respond_to do |format|
      format.json { render json: {star_partial: star_partial, starable_id: starable[:id], starable_type: starable[:type]} }
      format.html { redirect_to user_path(current_user) }
    end
  end

  private

    def star_params
      params.require(:star).permit(:starable_id, :starable_type)
    end
end

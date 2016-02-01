class StarsController < ApplicationController
  def create
    @star = Star.new(star_params)
    @star.save
    unstar_partial = render_to_string(partial: 'stars/unstar', locals: {star: @star})
    render json: {unstar_partial: unstar_partial, star: @star}
  end

  def destroy
    @star = Star.find(params[:id])
    starable_id = @star.starable_id
    starable_type = @star.starable_type
    star_partial = render_to_string(partial: 'stars/star', locals: {starable: @star.starable})
    @star.destroy
    render json: { star_partial: star_partial, starable_id: starable_id, starable_type: starable_type }
  end

  private

    def star_params
      params.require(:star).permit(:starable_id, :starable_type)
    end
end

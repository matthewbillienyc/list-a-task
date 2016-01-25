class StarsController < ApplicationController
  def create
    star = Star.new(star_params)
    star.save
    redirect_to user_path(current_user)
  end

  def destroy
    star = Star.find(params[:id])
    star.destroy
    redirect_to user_path(current_user)
  end

  private

  def star_params
    params.require(:star).permit(:starable_id, :starable_type)
  end
end

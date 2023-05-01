class RoomResourcesController < ApplicationController
  before_action :authenticate_user!

  def update
    resource = RoomResource.find params[:id]
    authorize! :update, resource
    if resource.update!(room_resource_params)
      render json: resource
    else
      render json: { errors: resource.errors }, status: :unprocessable_entity
    end
  end

private

  def room_resource_params
    params.require(:room_resource).permit(:amount)
  end
end

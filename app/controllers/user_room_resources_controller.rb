class UserRoomResourcesController < ApplicationController
  before_action :authenticate_user!

  def update
    resource = UserRoomResource.find params[:id]
    authorize! :update, resource
    if resource.update!(user_room_resource_params)
      render json: resource
    else
      render json: { errors: resource.errors }, status: :unprocessable_entity
    end
  end

private

  def user_room_resource_params
    params.require(:user_room_resource).permit(:ammount)
  end
end

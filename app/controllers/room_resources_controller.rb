class RoomResourcesController < ApplicationController
  before_action :authenticate_user!

  def increment
    resource = RoomResource.find params[:id]
    authorize! :update, resource

    resource.amount += 1
    resource.save
    render json: resource
  end

  def decrement
    resource = RoomResource.find params[:id]
    authorize! :update, resource

    resource.amount -= 1
    resource.save
    render json: resource
  end

private

  def room_resource_params
    params.require(:room_resource).permit(:amount)
  end
end

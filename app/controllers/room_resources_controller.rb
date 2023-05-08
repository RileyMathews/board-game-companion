class RoomResourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i(index)
  before_action :set_room_resource, only: %i(edit update)

  def index
    authorize! :play, @room
    @room_resources_grouped = @room.grouped_resources_for_player user: current_user
  end

  def edit
    authorize! :manage, @room_resource
  end

  def update
    authorize! :manage, @room_resource
    if @room_resource.update(room_resource_params)
      redirect_to room_room_resources_path(@room_resource.room), notice: "Resource amount updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

private

  def set_room
    @room = Room.find params[:room_id]
  end

  def set_room_resource
    @room_resource = RoomResource.find params[:id]
  end

  def room_resource_params
    params.require(:room_resource).permit(:amount)
  end
end

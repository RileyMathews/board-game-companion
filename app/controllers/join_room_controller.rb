class JoinRoomController < ApplicationController
  def find_room
    @room = Room.find_by join_code: params[:join_code]
    return unless @room.users.include? current_user

    redirect_to room_play_url(@room), notice: "You are already in this room."
  end

  def join_room
    room = Room.find_by join_code: params[:join_code]

    room.users << current_user

    redirect_to room_play_url(room)
  end
end

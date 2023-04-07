class HomeController < ApplicationController
  def index
    if user_signed_in?
      @active_rooms = current_user.rooms
    else
      @active_rooms = []
    end
  end
end

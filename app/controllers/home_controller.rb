class HomeController < ApplicationController
  def index
    @active_rooms = current_user.rooms
  end
end

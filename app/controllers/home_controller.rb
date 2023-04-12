class HomeController < ApplicationController
  skip_authorization_check

  def index
    @active_rooms = if user_signed_in?
                      UserRoom.eager_load(:room).where(user: current_user).map(&:room)
                    else
                      []
                    end
  end
end

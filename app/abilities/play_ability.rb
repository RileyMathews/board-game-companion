class PlayAbility
  include CanCan::Ability

  def initialize(user)
    can :play, Room do |room|
      room.users.include? user
    end

    can :archive, Roll, roll_log: { user_room: { user: user } }
  end
end

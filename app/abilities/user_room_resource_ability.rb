class UserRoomResourceAbility
  include CanCan::Ability

  def initialize(user)
    can :manage, UserRoomResource, user_room: { user_id: user.id }
  end
end

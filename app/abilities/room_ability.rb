class RoomAbility
  include CanCan::Ability

  def initialize(user)
    can :show, Room
    can :manage, Room, created_by_id: user.id
  end
end

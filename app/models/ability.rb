class Ability
  include CanCan::Ability

  def initialize(user)
    can :show, Die
    can :show, Face
    can :show, Game
    can :show, Resource
    can :show, ResourceGroup
    can :show, Room

    can :manage, Die, game: { created_by_id: user.id }
    can :manage, Face, die: { game: { created_by_id: user.id } }
    can :manage, Game, created_by_id: user.id
    can :play, Room do |room|
      room.users.include? user
    end
    can :manage, Roll, roll_log: { user_room: { user_id: user.id } }
    can :manage, Resource, game: { created_by_id: user.id }
    can :manage, ResourceGroup, game: { created_by_id: user.id }
    can :manage, Room, created_by_id: user.id
    can :manage, UserRoomResource, user_room: { user_id: user.id }
  end
end

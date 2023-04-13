class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    die_ability
    face_ability
    game_ability
    resource_ability
    resource_group_ability
    room_ability
    roll_ability
    room_resource_ability
    user_room_ability
  end

private

  def die_ability
    can :show, Die
    can :manage, Die, game: { created_by_id: @user.id }
  end

  def face_ability
    can :show, Face
    can :manage, Face, die: { game: { created_by_id: @user.id } }
  end

  def game_ability
    can :show, Game
    can :manage, Game, created_by_id: @user.id
  end

  def resource_ability
    can :show, Resource
    can :manage, Resource, game: { created_by_id: @user.id }
  end

  def resource_group_ability
    can :show, ResourceGroup
    can :manage, ResourceGroup, game: { created_by_id: @user.id }
  end

  def room_ability
    can :play, Room do |room|
      room.users.include? @user
    end
    can :manage, Room, created_by_id: @user.id
  end

  def roll_ability
    can :manage, Roll, roll_log: { user_room: { user_id: @user.id } }
  end

  def room_resource_ability
    can :manage, RoomResource, user_id: @user.id
  end

  def user_room_ability
    can :manage, UserRoom, user_id: @user.id
  end
end

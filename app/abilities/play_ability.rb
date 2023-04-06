class PlayAbility
  include CanCan::Ability

  def initialize(user)
    can :play, Room do |room|
      room.users.include? user
    end
  end
end

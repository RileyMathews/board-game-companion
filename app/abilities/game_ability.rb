class GameAbility
  include CanCan::Ability

  def initialize(user)
    can :manage, Game, created_by_id: user.id
  end
end

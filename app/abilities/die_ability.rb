class DieAbility
  include CanCan::Ability

  def initialize(user)
    can :show, Die
    can %i(new create), Die, game: { created_by_id: user.id }
    can :manage, Die, game: { created_by_id: user.id }
  end
end

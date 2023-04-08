class ResourceGroupAbility
  include CanCan::Ability

  def initialize(user)
    can :show, ResourceGroup
    can :manage, ResourceGroup, game: { created_by_id: user.id }
  end
end

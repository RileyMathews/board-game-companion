class ResourceAbility
  include CanCan::Ability

  def initialize(user)
    can :show, Resource
    can :manage, Resource, game: { created_by_id: user.id }
  end
end

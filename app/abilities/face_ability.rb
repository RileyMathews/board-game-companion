class FaceAbility
  include CanCan::Ability

  def initialize(user)
    can :manage, Face, die: { game: { created_by_id: user.id } }
  end
end

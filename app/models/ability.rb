class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Book, user_id: user.id
    can :manage, user
    return unless user.role == 'admin'

    can :manage, :all
  end
end

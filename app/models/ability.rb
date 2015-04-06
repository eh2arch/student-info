class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.admin?
      can :read, :all                   # allow everyone to read everything
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard                  # allow access to dashboard
      can :manage, :all
      # can :crud, :all             # allow superadmins to do anything
    end
  end
end

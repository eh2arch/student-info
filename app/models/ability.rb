class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all                   # allow everyone to read everything
    can :dashboard                  # allow access to dashboard
    if user && user.admin?
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :manage, :all
      # can :crud, :all             # allow superadmins to do anything
    end
  end
end

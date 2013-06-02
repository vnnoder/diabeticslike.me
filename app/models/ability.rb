class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, :edit, :to => :modify

    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all

    else
      can :create, [User, Experience, Image, Video, Availability, Conversation]
      # User resource
      can :modify, User do |resource|
        resource == user
      end

      # Profile
      can :manage, Profile do |profile|
        profile.user && profile.user == user
      end

      # Experience

      can :read, Experience
      can [:modify, :media], Experience do |resource|
        resource.user && resource.user == user
      end

      #Video
      can :read, Video

      can :read, Availability
      can [:modify], Availability do |resource|
        resource.user.nil? || (resource.user && resource.user == user)
      end

      can :manage, Conversation

    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end

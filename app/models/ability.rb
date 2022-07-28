# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 
    
    if user.admin?
        can :manage, :all
    end
    
    alias_action :create, :read, :update, :delete, to: :crud

    can :crud, Post do |post|
        user == post.user
    end

    can :crud, Comment do |comment|
        user == comment.user
    end
  end
end

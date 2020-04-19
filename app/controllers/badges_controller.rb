class BadgesController < ApplicationController
  def index
    @badges = Badge.all
  end

  def assigned
    @user_badges = UserBadge.where(user: current_user)
  end
end

class RelationshipsController < ApplicationController
  before_action :logged_in?
  respond_to? :js
  def create
    if logged_in?
      @user = User.find(params[:relationship][:followed_id])
      current_user.follow!(@user)
      @user
    else
      @user
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    @user
  end
end

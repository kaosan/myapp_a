class UsersController < ApplicationController
  before_action :logged_in?, only: [:show, :edit, :update, :favorite, :index, :following, :followers]
  def new
    @user = User.new
    render layout: 'users_new'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @favorite_posts_images = @user.favorite_posts
    @posts = @user.posts
    render layout: 'user_show'
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path, notice: "権限がありません"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path, notice: 'プロフィールを編集しました！'
    else
      render 'edit'
    end
  end

  def index
    @users = User.all
    render layout: 'users'
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon, :icon_cache, :user_id)
  end
end

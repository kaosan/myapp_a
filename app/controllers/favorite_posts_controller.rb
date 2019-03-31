  class FavoritePostsController < ApplicationController
  def create
    favorite_post = current_user.favorite_posts.create(post_id:   params[:post_id])
    redirect_to posts_url, notice: "#{favorite_post.post.user.name}さんの投稿をお気に入り登録しました"
  end

  def destroy
    favorite_post = current_user.favorite_posts.find_by(id:   params[:id]).destroy
    redirect_to posts_url, notice: "#{favorite_post.post.user.name}さんの投稿をお気に入り解除しました"
  end

  def index
    @user = User.find(session[:user_id])
    @favorites_post_images = @user.favorite_posts

  end

end

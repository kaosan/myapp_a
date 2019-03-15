class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
before_action :logged_in?, only: [:new, :edit, :destroy]

def index
  @posts = Post.all
end

def new
  if params[:back]
    @post = Post.new(post_params)
  else
    @post = Post.new
  end
end

def create
  @post = Post.new(post_params)
  @post.user_id = current_user.id
  if @post.save
    ContactMailer.contact_mail(@post).deliver
    redirect_to posts_path, notice: '投稿し、投稿確認メールを送信しました'
  else
    render 'new'
  end
end

def show
  @favorite_post = current_user.favorite_posts.find_by(post_id: @post.id)
  @comments = @post.comments
  @comment = @post.comments.build
end

def edit
  unless @post.user_id == current_user.id
    redirect_to posts_path, notice: "権限がありません"
  end
end

def update
  if @post.update(post_params)
    redirect_to posts_path, notice: '投稿を編集しました'
  else
    render 'edit'
  end
end

def destroy
  @post.destroy
  redirect_to posts_path, notice: '投稿を削除しました'
end

def confirm
  @user = User.find(session[:user_id])
  @post = Post.new(post_params)
  @post.user_id = current_user.id
  render :new if @post.invalid?
end

def search
  @posts = Post.all
  @search = Post.ransack(params[:q])
  @posts = @search.result(distinct: true)
end

private

def post_params
   params.require(:post).permit(:image, :content, :image_cache)
end

def set_post
@post = Post.find(params[:id])
end

def logged_in?
  unless current_user.present?
    flash[:notice] = 'ログインしてください'
    redirect_to new_session_path
  end
end

end

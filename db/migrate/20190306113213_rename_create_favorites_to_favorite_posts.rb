class RenameCreateFavoritesToFavoritePosts < ActiveRecord::Migration[5.1]
  def change
    rename_table :create_favorites, :favorite_posts
  end
end

class RenamePostsIdColumnToFavoritePosts < ActiveRecord::Migration[5.1]
  def change
    rename_column :favorite_posts, :posts_id, :post_id
  end
end
